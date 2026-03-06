extends CharacterBody2D





var target_pos : Vector2

@onready var track_component : TrackComponent = $TrackComponent
@onready var movement_component : Movement_component = $movement_component

@onready  var health_component : Health_component = $Health_component

@export var exclusions_path : Array[NodePath]

@export var nr_of_rays : int = 8
@export var ray_length : float

@export var switch_rate : int

var frame : int = 1

@export var damage : float = 2

@export var in_house : bool


func _enter_tree():
	Global.smoother.add_include_node(self)

func _exit_tree():
	Global.smoother.remove_include_node(self)

func  _ready():
	if in_house and Global.using_save:
		Data.zombies.erase(self)
		call_deferred("queue_free")
	
	
	$AudioStreamPlayer2D.volume_db=Global.volume
	generate_rays()
	global_rotation=0
	#visible=false
	call_deferred('reparent',Global.entity_folder,true)
	Data.zombies[self]=1
	

@onready var sprite = $Sprite2D

var dir : Vector2
func _physics_process(delta):
	frame+=1
	
	#if smoothed==false and Global.smoother:
	#	Global.smoother.add_include_node(self)
	#	smoothed=true
	target_pos=track_component.target_position
	
	if frame%switch_rate==0 and target_pos!=Vector2.ZERO:
		dir= calculate_best_move()
	
	if dir.x>0:
		sprite.flip_h=false
	elif dir.x<0:
		sprite.flip_h=true
	movement_component.add_movement(dir*movement_component.speed)
	movement_component.simulate_frame()
	
var movement_rays : Dictionary

func generate_rays()->void:
	var x : float = 0
	var add : float = 360.0 / nr_of_rays
	
	while x <360:
		var r : RayCast2D = RayCast2D.new()
		r.enabled=true
		r.target_position=Vector2(cos(deg_to_rad(x)),sin(deg_to_rad(x)))*ray_length
		
		for i in exclusions_path:
			r.add_exception(get_node(i))
		add_child(r)
		movement_rays[x] = r
		x+=add

func calculate_best_move()->Vector2:
	var best_score : float = 720
	var best_dir : Vector2
	for i in movement_rays.keys():
		var dir_vec : Vector2 = Vector2(cos(deg_to_rad(i)),sin(deg_to_rad(i)))
		var  score : float = abs(rad_to_deg(dir_vec.angle_to(global_position.direction_to(target_pos))))
		#print(i,' ' , rad_to_deg(global_position.angle_to(target_pos)) ,' ', score)
		if movement_rays[i].is_colliding() and movement_rays[i].get_collider()!=Global.player:
			score+=360
		#print(i,' ',i-rad_to_deg(global_position.angle_to(target_pos)))
		
		if score<best_score:
			
			#print(score)
			best_score=score
			best_dir=dir_vec
	#print(best_dir)

	#print(res)
	#print('-----')
	
	return best_dir



var blood = preload("res://Scenes/blood.tscn")

func Die()->void:
	Data.score+=1
	var i : Sprite2D = blood.instantiate()
	i.global_position = global_position
	Global.no_collision_props_folder.add_child(i)
	Data.zombies.erase(self)


func _on_attack_area_body_entered(body):
	if body==Global.player:  
		$AttackArea/CollisionShape2D.set_deferred("disabled",true)
		body.get_node('Health_component').TakeDamage(damage)
		var dir : Vector2 = global_position.direction_to(body.global_position)
		body.get_node('Movement_component').add_movement(dir*600)
		await get_tree().create_timer(0.3).timeout
		$AttackArea/CollisionShape2D.set_deferred("disabled",false)

var z_sound_hit  = preload("res://Resources/zombie_sound.wav")
var z_roar = preload("res://Resources/zombie_roar.wav")
var z_roar_2 = preload("res://Resources/zombie_roar2.wav")
func _on_sound_timer_timeout():
	if randi()%2:
		Global.audio_listener.global_position=global_position
		if randi()%2:
			$AudioStreamPlayer2D.stream=z_roar
		else:
			$AudioStreamPlayer2D.stream=z_roar_2
		$AudioStreamPlayer2D.play()

func taken_hit():
	Global.audio_listener.global_position=global_position
	$AudioStreamPlayer2D.stream=z_sound_hit
	$AudioStreamPlayer2D.play()

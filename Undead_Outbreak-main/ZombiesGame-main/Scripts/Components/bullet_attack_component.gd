extends Node2D
class_name Bullet_attack_component

#var bullet : PackedScene = preload()

@export var movement_component : Movement_component
@export var audio : AudioStreamPlayer2D


var bullet = preload("res://Scenes/bullet.tscn")

var total_bullets : int

var selected_weapon : weapon
var nr_of_loaded_bullets : int =0
var reload_time : float = 0
var cool_time : float =0
var recoil_time : float

var mag_items  : base_item

var shoot_sound
var reload_sound


func _ready():
	Global.bullet_component=self
	pass



func clear_weapon()->void:
	Data.mag_size=0
	for i in get_children():
		i.queue_free()
	Global.player_inv.add_item(mag_items,nr_of_loaded_bullets)
	nr_of_loaded_bullets=0
	selected_weapon=null
	
	
func change_weapon(wp : weapon)->void:
	clear_weapon()
	
	#for i in get_children():
	#	i.queue_free()
	
	if wp.sprite!='':
		var sp : TextureRect= TextureRect.new()
		sp.expand_mode=TextureRect.EXPAND_IGNORE_SIZE
		sp.stretch_mode=TextureRect.STRETCH_KEEP_ASPECT_CENTERED
		sp.texture=load(wp.sprite)
		sp.size=wp.size
		sp.position=wp.offset
		add_child(sp)
	
	shoot_sound=null
	reload_sound=null
	
	selected_weapon=wp
	if selected_weapon.shoot_sound.is_empty()==false:
		shoot_sound=load(selected_weapon.shoot_sound)
	if selected_weapon.reload_sound.is_empty()==false:
		reload_sound=load(selected_weapon.reload_sound)
	Data.mag_size=selected_weapon.mag_size
	reload_time=0
	cool_time=0
	recoil_time=0


func _process(delta):
	if rl_precentage_add!=0:
		Data.reload_percentage+=rl_precentage_add*delta
	look_at(Global.global_mouse_position)
	if reload_time>0:
		reload_time-=delta
	if cool_time>0:
		cool_time-=delta
	if recoil_time>0:
		if recoil_time>2:
			recoil_time-=recoil_time*delta*4
		else:
			recoil_time-=delta*1.3



var rl_precentage_add : float
func reload()->void:
	if selected_weapon==null:
		return
	if reload_time>0:
		return
	reload_time = selected_weapon.reload_time
	if reload_sound:
		Global.audio_listener.global_position=global_position
		audio.stream=reload_sound
		audio.play()
	Data.reload_percentage=0
	
	
	Data.reload_percentage=0 
	rl_precentage_add=100.0/reload_time
	await get_tree().create_timer(reload_time).timeout
	rl_precentage_add=0
	Data.reload_percentage=0
	if selected_weapon==null:
		return
	
	var possible : int = Global.player_inv.get_amount_of_type(selected_weapon.bullet_type)
	var needed : int = selected_weapon.mag_size-nr_of_loaded_bullets
	if Global.player_inv.get_item_of_type(selected_weapon.type)!=null:
		mag_items=Global.player_inv.get_item_of_type(selected_weapon.bullet_type)
	nr_of_loaded_bullets +=min(needed,possible)
	Global.player_inv.delete_type(selected_weapon.bullet_type,min(needed,possible))
	
	
	

func try_to_attack()->void:
	if !Global.player_inv:
		return
	if Global.player_inv.open:
		return
	if selected_weapon==null:
		return
	
	if reload_time<=0 and cool_time<=0 and nr_of_loaded_bullets>=selected_weapon.bullet_direction.size():
		
		Global.camera.shake(0.1,0.5)
		Global.Control_Hud.shake(0.1,0.75)
		
		var rnd : int = -1
		if randi()%2:
			rnd=-rnd
		var r_factor : float = deg_to_rad(recoil_time*selected_weapon.recoil_force * rnd)
		var f : float =randf_range(0,r_factor)
		
		nr_of_loaded_bullets-=selected_weapon.bullet_direction.size()
		cool_time=selected_weapon.cool_down
		
		var dir_2_mouse : Vector2 = global_position.direction_to(Global.global_mouse_position)
		
		
		
		if recoil_time>0:
			create_attack(selected_weapon.get_attack(dir_2_mouse.rotated(f)))
		else:
			create_attack(selected_weapon.get_attack(dir_2_mouse))
		
		if shoot_sound!=null:
			Global.audio_listener.global_position=global_position
			audio.stream=shoot_sound
			audio.play()
		
		
		if recoil_time<1:
			recoil_time+=0.3
		else:
			recoil_time*=1.35
		if recoil_time>30:
			recoil_time=30
			
		movement_component.add_movement(-dir_2_mouse*selected_weapon.recoil_force*45)
func create_attack(at : weapon_attack)->void:
	var result : Array[Object] =[]
	for i in at.bullet_direction:
		var b_dir : Vector2 = at.direction.rotated(deg_to_rad(i))
		var r : RayCast2D = RayCast2D.new()
		var b : Line2D = bullet.instantiate()
		#print(rad_to_deg(atan2(b_dir.y,b_dir.x)))
		#print(b_dir)
		r.target_position=b_dir*at.bullet_length
		r.global_position=global_position 
		#r.global_position=get_parent().global_position
		r.hit_from_inside=true
		for j in get_tree().get_nodes_in_group("player"):
			r.add_exception(j)
		Global.visuals_folder.add_child(r)
		
		
		
		r.force_raycast_update()
		result.push_back(r.get_collider())
		if r.get_collider()!=null:
			b.target=Vector2(r.get_collision_point())-global_position
			if r.get_collider().is_in_group('enemy'):
				var c = r.get_collider()
				c.health_component.TakeDamage(selected_weapon.bullet_damage)
				c.movement_component.add_movement(global_position.direction_to(c.global_position)*selected_weapon.knock_power)
				
			elif r.get_collider().has_method('TakeDamage'):
				r.get_collider().TakeDamage(selected_weapon.bullet_damage)
			
		else:
			b.target=r.target_position
		
		b.global_position=global_position 
		#add_child(b)
		Global.visuals_folder.add_child(b)
		r.queue_free()
	


func _on_check_if_weapon_timeout():
	if selected_weapon==null:
		return
	
	if Global.player_inv.get_amount_of_type(selected_weapon.type)<1:
		clear_weapon()
		return
	return

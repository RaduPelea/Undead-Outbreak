extends Node
class_name User_input_component

@export var player_movement_component : Movement_component
@export var bullet_attack_component : Bullet_attack_component
@export var sprite : Sprite2D
@export var stamina_component : Stamina_component

func _ready():
	Global.player=get_parent()

func _physics_process(delta):
	handle_movement()
	sprint(delta)
	handle_actions()
	set_visuals()
	player_movement_component.simulate_frame()

func sprint(delta)->void:
	if Input.is_action_pressed("sprint") and stamina_component.stamina>0 and !stamina_component.blocked:
		stamina_component.stamina-=40*delta
		player_movement_component.multiply_movement(1.35)
	if stamina_component.stamina<2:
		stamina_component.blocked=true
		await get_tree().create_timer(2).timeout
		stamina_component.blocked=false

func set_visuals()->void:
	if player_movement_component.motion.x>0:
		sprite.flip_h=false
	elif player_movement_component.motion.x<0:
		sprite.flip_h=true
	if Global.global_mouse_position.x-sprite.global_position.x > 0:
		if bullet_attack_component.selected_weapon:
			bullet_attack_component.position=bullet_attack_component.selected_weapon.b_component_pos
			
			for i in bullet_attack_component.get_children():
				if i is TextureRect:
					i.flip_v=false
	else:
		if bullet_attack_component.selected_weapon:
			bullet_attack_component.position=bullet_attack_component.selected_weapon.b_component_pos
			bullet_attack_component.position.x*=-1
			bullet_attack_component.position.y+=2
			for i in bullet_attack_component.get_children():
				if i is TextureRect:
					i.flip_v=true

func get_movement_inputs()->Vector2:
	var m : Vector2
	m.x=Input.get_axis("ui_left","ui_right")
	m.y=Input.get_axis("ui_up","ui_down")
	return m

func handle_movement()->void:
	player_movement_component.add_movement(player_movement_component.speed*(get_movement_inputs().normalized()))

@onready var inter_coll = $"../InteractArea/CollisionShape2D"

var can_interact : bool = true
func handle_actions()->void:
	if Input.is_action_pressed("Primary"):
		bullet_attack_component.try_to_attack()
	if Input.is_action_pressed("reload"):
		bullet_attack_component.reload()
	if Input.is_action_just_pressed("interact") and can_interact:
		inter_coll.set_deferred("disabled",false)
		can_interact=false
		await get_tree().create_timer(0.2).timeout
		can_interact=true
		inter_coll.set_deferred("disabled",true)
	if Input.is_action_just_pressed("empty_hands"):
		bullet_attack_component.clear_weapon()

func _on_interact_area_body_entered(body):
	if body.is_in_group('Crate'):
		body.toggle_inventory()

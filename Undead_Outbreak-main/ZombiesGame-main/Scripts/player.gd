extends CharacterBody2D

func _ready():
	$AudioStreamPlayer2D.volume_db=Global.volume
	Global.antidote_syringe_display.frame=3

func Die()->void:
	Global.player_inv=null
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")

func Win()->void:
	Global.player_inv=null
	get_tree().change_scene_to_file("res://Scenes/win_screen.tscn")

@onready var health_c = $Health_component
@onready var hunger_c = $Hunger_component
@onready var stamina_c = $Stamina_component
@onready var bullet_comp = $Bullet_attack_component
@onready var cam = $Camera2D
func set_player()->void:
	health_c.health=SaveSystem.game_data['health']
	hunger_c.hunger=SaveSystem.game_data['hunger']
	stamina_c.stamina=SaveSystem.game_data['stamina']
	hunger_c.water =SaveSystem.game_data['thirst']

func _process(delta):
	
	Data.health=health_c.health
	Data.hunger=hunger_c.hunger
	Data.thirst=hunger_c.water
	Data.stamina=stamina_c.stamina
	Data.nr_of_loaded_bullets=bullet_comp.nr_of_loaded_bullets
	Global.player_health=health_c
	Global.player_hunger=hunger_c
	Global.camera=cam
	Global.local_mouse_position=get_local_mouse_position()
	
	
	if abs(global_position.x) > 1720 and abs(global_position.y) > 1720:
		found_antidote_part()

func found_antidote_part()->void:
	var best : Vector2
	var dmin : float = 1720^3
	for i in Global.goals.keys():
		if Global.goals[i]==false:
			if i.distance_to(global_position) < dmin : 
				best=i
				dmin=i.distance_to(global_position)
	
	if dmin>100:
		return
	
	Global.goals[best]=true
	
	print('found antidote part')
	
	
	if Global.antidote_parts_found<4:
		Global.antidote_syringe_display.frame=3-Global.antidote_parts_found
	
		
	if Global.antidote_parts_found==4:
		Win()
	
	



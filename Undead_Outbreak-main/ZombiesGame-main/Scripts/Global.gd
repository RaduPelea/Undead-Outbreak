extends Node2D



var global_mouse_position : Vector2
var local_mouse_position : Vector2

var hud : CanvasLayer

var visuals_folder : Node2D

var fps : float
var dificulty_divider : int = 1
var player_inv : Control
var player_health : Health_component
var player_hunger : Hunger_component

var high_graphics : bool = false
var show_fps : bool = true
var full_screen : bool = false
var entity_folder : Node2D
var Vsync : bool = false
var player : CharacterBody2D

var bullet_component : Bullet_attack_component

var smoother : Node

var seed : int = -1


var using_save : bool = false

var audio_listener : AudioListener2D

var no_collision_props_folder : Node2D

var camera : Camera2D

var Control_Hud : Control

var house_array : Array[Node2D]


var volume : float = 0

var antidote_syringe_display : Sprite2D


var single_prop_tiles : Array= [preload("res://Resources/sprite_0055.png"),
								preload("res://Resources/sprite_0052.png"),
								preload("res://Resources/sprite_0053.png"),
								preload("res://Resources/sprite_0054.png"),
								preload("res://Resources/sprite_0066.png"),
								preload("res://Resources/sprite_0069.png"),
								preload("res://Resources/sprite_0071.png"),

]
var single_prop_road_tiles : Array = [
	preload("res://Resources/concretecrack_-_Copy_-_Copy.png"),
	preload("res://Resources/concretecrack2_-_Copy.png"),
	preload("res://Resources/concretecrack3.png"),

]

var goals : Dictionary = {
	Vector2(1720,1720) : false,
	Vector2(-1720,-1720) : false,
	Vector2(1720,-1720) : false,
	Vector2(-1720,1720) : false,
}

var antidote_parts_found : int :
	get:
		var s : int =0
		for i in goals.values():
			if i==true:
				s+=1
		return s


func clear_data()->void:
	house_array.clear()
	goals = {
		Vector2(1720,1720) : false,
		Vector2(-1720,-1720) : false,
		Vector2(1720,-1720) : false,
		Vector2(-1720,1720) : false,
	}
	antidote_parts_found=0



func _process(delta):
	global_mouse_position=get_global_mouse_position()
	fps = Engine.get_frames_per_second()

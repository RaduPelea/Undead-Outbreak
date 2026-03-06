extends Node
class_name Stamina_component

var stamina : float = 100
@export var parent_node : CharacterBody2D
@export var stamina_recharge : float

var blocked : bool = false


func _process(delta):
	if stamina<100:
		stamina+=delta*stamina_recharge
	

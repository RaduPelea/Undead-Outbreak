extends Node
class_name Hunger_component

var ok : bool = true
var hunger : float = 100
var water : float = 100
var hunger_value : float = 0.1
var water_value : float = 0.1

@export var parent_health_component : Health_component



func _process(delta):
	hunger-=hunger_value*delta
	water-=water_value*delta
	if hunger<=0:
		parent_health_component.TakeDamage(0.1*delta)
	if water<=0:
		parent_health_component.TakeDamage(0.1*delta)

func regenerate_hunger(val : float)->void:
	hunger+=val
	hunger=min(hunger,100)
func regenerate_thirst(val : float)->void:
	water+=val
	water=min(water,100)

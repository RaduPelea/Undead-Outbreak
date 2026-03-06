extends Node
class_name Health_component


@export var health : float
@export var parent_node : Node2D


var blood_part : PackedScene = preload("res://Scenes/blood_particles.tscn")



func TakeDamage(damage : float)->void:
	
	var b := blood_part.instantiate()
	b.global_position = parent_node.global_position
	Global.visuals_folder.add_child(b)
	
	health-=damage
	if parent_node.has_method('taken_hit'):
		parent_node.taken_hit()
	
	if health<=0:
		if parent_node.has_method('Die'):
			parent_node.Die()
		parent_node.queue_free()


func regenerate(val : float)->void:
	health+=val
	health=min(health,10)

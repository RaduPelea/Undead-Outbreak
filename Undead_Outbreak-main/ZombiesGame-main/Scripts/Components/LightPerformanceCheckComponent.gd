extends Node
class_name LightPerformanceComponent

@export var check_targets : Array[NodePath]

func _ready():
	Update()

func Update()->void:
	for i in check_targets:
		get_node(i).enabled =Global.high_graphics
	

extends Node2D



var nearby_houses : Dictionary


@export var points_to_check : Array[Vector2]

@export var exclusions : Array[NodePath]


@onready var r : RayCast2D = $RayCast2D

func _ready():
	for i in exclusions:
		r.add_exception(get_node(i))

func show_visible()->void:
	for i in nearby_houses.keys():
		i.hide_house()
	nearby_houses.clear()
	
	
	for j in points_to_check:
		r.position=j
		for i in range(0,360):
			r.rotation_degrees=i
			r.force_raycast_update()
			#print(r.get_collider())
			#print(r.get_collider().name)
			var c : Object = r.get_collider()
			if c and c is Area2D and c.get_parent().has_method('show_house'):
				nearby_houses[r.get_collider().get_parent()]=true
				r.get_collider().get_parent().show_house()
	
	



func _on_timer_timeout():
	show_visible()

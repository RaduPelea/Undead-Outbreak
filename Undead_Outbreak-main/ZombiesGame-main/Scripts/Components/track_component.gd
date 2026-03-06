extends Node2D
class_name TrackComponent
@export var exclusions : Array[NodePath]

@onready var target :  CharacterBody2D 

@export var range : float

@export var raycast_positions : Array[Vector2]

@export var vision_delay : int


var ray : RayCast2D

var frame : int = 1

func _ready():
	ray=RayCast2D.new()
	ray.target_position=Vector2(range,0)
	ray.hit_from_inside = true
	for i in exclusions:
		ray.add_exception(get_node(i))
	add_child(ray)

func can_see_player()->void:
	for i in raycast_positions:
		ray.position=i
		ray.look_at(Global.player.global_position)
		ray.force_raycast_update()
		if ray.get_collider()==Global.player:
			target_position=ray.get_collision_point()
			return



var target_position : Vector2

func _physics_process(delta):
	movement()
	
	#if global_position.distance_squared_to(target.global_position)>range_2:
	#	return
	

func movement()->void:
	if !target:
		target=Global.player
		return
	frame+=1
	if frame%vision_delay==0:
		can_see_player()
	
	

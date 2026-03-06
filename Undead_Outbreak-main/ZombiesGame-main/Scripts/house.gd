extends Node2D
@export var corners : Node2D

@export var roof : Sprite2D
@export var tiles : Node2D



var x_min : int
var y_min : int 
var x_max : int
var y_max : int

func precalc()->void:
	x_min  =poz_to_map(corners.get_child(1).global_position.x) 
	y_min  =poz_to_map(corners.get_child(1).global_position.y)
	x_max  =poz_to_map(corners.get_child(1).global_position.x)
	y_max =poz_to_map(corners.get_child(1).global_position.y)
	for i in corners.get_children():
		x_min=min(x_min,poz_to_map(i.global_position.x))
		x_max=max(x_max,poz_to_map(i.global_position.x))
		y_min=min(y_min,poz_to_map(i.global_position.y))
		y_max=max(y_max,poz_to_map(i.global_position.y))

func can_cover()->bool:
	for i in range(x_min,x_max+1):
		for j in range(y_min,y_max+1):
			#print(Vector2i(i,j))
			if Data.full_map.has(Vector2i(i,j)) and Data.full_map[(Vector2i(i,j))]:
				return false
	return true

func cover()->void:
	
	for i in range(x_min,x_max+1):
		for j in range(y_min,y_max+1):
			#print(i,' ',j)
			if Data.full_map.has(Vector2i(i,j)):
				Data.full_map[Vector2i(i,j)]=2
	

func poz_to_map(a  : int)->int:
	var res : int = a/16
	#if a<0:
	#	res-=1
	return res



func show_house()->void:
	if roof:
		roof.visible=false
	tiles.visible=true


func hide_house()->void:
	if roof:
		roof.visible=true
	tiles.visible=false
	

extends Node2D

var map : Dictionary

var map_modifier : int = 5

@export var map_size : int =1 

@onready var tmap : TileMap = $TileMap

var zombie = preload("res://Scenes/zombie.tscn")
var single_prop_tile = preload("res://Scenes/single_tile_prop.tscn")
var single_prop_road_tile = preload("res://Scenes/single_tile_road_prop.tscn")

var nr_hidden
var house_array = [ preload("res://Scenes/house_1.tscn"),
					preload("res://Scenes/house_2.tscn"),
					preload('res://Scenes/house_3.tscn'),
					preload('res://Scenes/hospital.tscn'),
					preload('res://Scenes/police_station.tscn'),
					preload("res://Scenes/market.tscn"),
					preload("res://Scenes/office.tscn")]
					

@onready var ent = $Entities

var using_save : bool = false


var x1 : int  
var x2 : int  
var y1 : int 
var y2 : int 

var nr_of_zombs : int

func _ready():
	Data.score=0
	x1 = -map_size*map_modifier+map_modifier
	x2 = (map_size-1)*map_modifier+1
	y1 = -map_size*map_modifier+map_modifier
	y2 = (map_size-1)*map_modifier+1
	randomize()
	Data.clear_data()
	Global.clear_data()
	
	if SaveSystem.load_data():
		seed(Global.seed)
		using_save=true
		Global.using_save=true
	else:
		Global.player_inv.add_item(Data.pistol_item,1)
		Global.player_inv.add_item(Data.small_bullets,30)
		var s = randi()
		Global.seed=s
		using_save=false
		Global.using_save=false
	
	InventoryHandler.appear_ghost()
	if Global.antidote_parts_found<4:
		Global.antidote_syringe_display.frame=3-Global.antidote_parts_found
	
	map=$MapGenerator.GenMap(map_size)
	Global.audio_listener=$AudioListener2D
	Global.smoother=$Entities/Smoother
	Global.entity_folder=$Entities
	Global.no_collision_props_folder=$NoCollisionProps
	#$NoCollisionProps.process_mode=Node.PROCESS_MODE_DISABLED
	
	for i in range(-map_size-1,map_size+2):
		for x in range(0,map_modifier+1):
			for y in range(0,map_modifier+1):
				tmap.set_cell(0,Vector2i(i*map_modifier+x,(-map_size-1)*map_modifier+y),0,Vector2i(7,7))
				tmap.set_cell(0,Vector2i(i*map_modifier+x,(map_size+1)*map_modifier+y),0,Vector2i(7,7))
				tmap.set_cell(0,Vector2i(((map_size+1)*map_modifier+x),i*map_modifier+y),0,Vector2i(7,7))
				tmap.set_cell(0,Vector2i(((-map_size-1)*map_modifier+x),i*map_modifier+y),0,Vector2i(7,7))
				
				
				
	for i in range(-map_size,map_size+1):
		for j in range(-map_size,map_size+1):
			if map.has(Vector2i(i,j)):
				for x in range(0,map_modifier+1):
					for y in range(0,map_modifier+1):
						Data.full_map[Vector2i(i*map_modifier+x,j*map_modifier+y)]=1
						tmap.set_cell(0,Vector2i(i*map_modifier+x,j*map_modifier+y),0,Vector2i(6,7))
			else:
				for x in range(0,map_modifier+1):
					for y in range(0,map_modifier+1):
						tmap.set_cell(0,Vector2i(i*map_modifier+x,j*map_modifier+y),0,Vector2i(1,7))
						Data.full_map[Vector2i(i*map_modifier+x,j*map_modifier+y)]=0
					#tmap.set_cell(0,Vector2i(i*map_modifier+x,j*map_modifier+X),-1,Vector2i(6,7))
	

	
	gen_houses(x1,x2)
	
	
	create_zombies()
	if Global.high_graphics:
		for i in range(x1,x2):
			for j in range(y1,y2):
				if  randi()%16==0 and Data.full_map[Vector2i(i,j)]==0:
					var s : Sprite2D = single_prop_tile.instantiate()
					s.global_position = Vector2i(i*16+8,j*16+8)
					$NoCollisionProps.add_child(s)
					nr_props+=1
				if randi()%21==0 and Data.full_map[Vector2i(i,j)]==1:
					var s : Sprite2D = single_prop_road_tile.instantiate()
					s.global_position = Vector2i(i*16+8,j*16+8)
					$NoCollisionProps.add_child(s)
					nr_props+=1
					
	

func gen_houses(v1 : int,v2 : int)->void:
	for i in range(v1,v2):
		for j in range(y1,y2):

			if Data.full_map[Vector2i(i,j)]!=0 || randi()%5!=0 :
				continue
				
			var ind : int = randi()%24
			if ind < 13 : # adaug casa
				ind=ind%3
			else : # adaug spital sau sectie de politie
				ind = 3 + ind%4
			
			var h : PackedScene = house_array[ind]
			#print(ind)
			if Create_house(Vector2i.UP,90,i,j,h):
				pass
			elif Create_house(Vector2i.LEFT,0,i,j,h):
				pass
			elif Create_house(Vector2i.RIGHT,180,i,j,h):
				pass
			elif Create_house(Vector2i.DOWN,270,i,j,h):
				pass
			
func create_zombies()->void:
	if using_save:
		return
	for i in range(x1-32,x2+32):
		for j in range(y1-32,y2+32):
			gen_zombie(i,j)
	
func gen_zombie(i : int,j : int)->void:
	var chance : float = min((map_size-1)*map_modifier+1-i,i+map_size*map_modifier-map_modifier)
	chance=min(chance,(map_size-1)*map_modifier+1)
	chance=min(chance,j+map_size*map_modifier-map_modifier)
	chance/=Global.dificulty_divider
	if chance<=0:
		chance=1
	if randi()%4==0 and randi()%(int(chance)+1)== 0 and (Data.full_map.has(Vector2i(i,j))==false or Data.full_map[Vector2i(i,j)]<2):
		var z : CharacterBody2D = zombie.instantiate()
		z.global_position = Vector2i(i*16,j*16)
		Data.zombies[z]=1
	

func compute_hidden()->void:
	nr_hidden=0
	for i in ent.get_children():
		if i is CharacterBody2D:
			if i.visible==false:
				nr_hidden+=1
	print(nr_hidden)

func Create_house(angle : Vector2i,rot : float,i : int,j : int,hous : PackedScene)->bool:
	if !(Data.full_map[Vector2i(i,j)+angle]==1 and Data.full_map[Vector2i(i,j)]==0):
		return false
	
	var h = hous.instantiate()
	h.global_position = Vector2i(i*16,j*16)
	h.rotation_degrees = rot
	h.precalc()
	if h.can_cover():
		h.cover()
		if using_save:
			for x in h.get_children():
				if x.is_in_group('enemy'):
					x.call_deferred('queue_free')
		Global.house_array.push_back(h)
		
		
		
		return true
	else:
		h.queue_free()
		return false
	


func add_zombies(pos : Vector2)->void:
	for i in Data.zombies.keys():
		if i==null:
			Data.zombies.erase(i)
			continue
		
		if  i.global_position.distance_squared_to(pos)<160000:
			if i.is_inside_tree()==false:
				ent.add_child(i)
				#Global.smoother.add_include_node(i)
		else:
			if i.is_inside_tree()==true:
				#Global.smoother.remove_include_node(i)
				ent.remove_child(i)

var Arr_of_props : Array[Sprite2D]

var nr_props : int 

func _on_render_zombies_timeout():
	if !Global.player:
		return 
	add_zombies(Global.player.global_position)
	for i in $NoCollisionProps.get_children():
		if i.global_position.distance_squared_to(Global.player.global_position)>90000:
			i.visible=false
			
		else:
			i.visible=true

func _on_render_houses_timeout():
	for i in Global.house_array:
		if i.global_position.distance_squared_to(Global.player.global_position)>1250000:
			if i.is_inside_tree():
				ent.remove_child(i)
			i.visible=false
		else:
			if !i.is_inside_tree():
				ent.add_child(i)
				
			i.visible=true

extends Node



var pistol : weapon = weapon.new()
var pistol_item : base_item = base_item.new()


var ak47 : weapon = weapon.new()
var ak47_item : base_item = base_item.new()

var shotgun : weapon =weapon.new()
var shotgun_item : base_item=base_item.new()

var sniper : weapon = weapon.new()
var sniper_item : base_item = base_item.new()

var minigun : weapon =weapon.new()
var minigun_item : base_item= base_item.new()


var uzzi : weapon=weapon.new()
var uzzi_item : base_item = base_item.new()

var medkit : base_item = base_item.new()
var food : base_item = base_item.new()
var bottle : base_item = base_item.new()
var small_bullets : base_item = base_item.new()
var medium_bullets : base_item = base_item.new()
var shotgun_bullets : base_item = base_item.new()
var sniper_bullets : base_item = base_item.new()

var weapons : Dictionary


var loot_table1 : Dictionary
var loot_table2 : Dictionary
var loot_table3 : Dictionary
var full_map : Dictionary

var zombies : Dictionary


var health : float
var hunger : float
var thirst : float
var stamina : float

var nr_of_loaded_bullets : int 
var mag_size : int
var reload_percentage : float

var score : int 

func set_weapons()->void:
	set_pistol()
	set_shotgun()
	set_minigun()
	set_sniper()
	set_uzzi()
	set_ak47()
	#uzzi.set_up([0],120,5,0.05,40,3,3.25,'medium_bullets')
	#ak47.set_up([0],500,23,0.1,30,4,2.85,'heavy_bullets')



func clear_data()->void:
	full_map.clear()
	zombies.clear()


func set_consumables()->void:
	small_bullets.set_up(99,"res://Resources/pistol_bullet.png",'small_bullets')
	small_bullets.add_to_loot_table2(50,0,50)
	medium_bullets.set_up(99,"res://Resources/medium_bullet.png",'medium_bullets')
	medium_bullets.add_to_loot_table2(50,0,35)
	sniper_bullets.set_up(99,"res://Resources/sniper_bullet.png",'sniper_bullets')
	sniper_bullets.add_to_loot_table2(20,0,15)
	shotgun_bullets.set_up(99,"res://Resources/shotgun_bullet.png",'shotgun_bullets')
	shotgun_bullets.add_to_loot_table2(40,0,25)
	medkit.set_up(99,"res://Resources/medkit.png","medkit",'health_recovery',50)
	medkit.add_to_loot_table3(1,0,25)
	food.set_up(99,"res://Resources/conserva.png","food",'hunger_recovery',50)
	food.add_to_loot_table3(1,0,35)
	bottle.set_up(99,"res://Resources/waterbottle2.png","bottle",'thirst_recovery',50)
	bottle.add_to_loot_table3(1,0,35)
func _ready():
	
	set_weapons()
	set_consumables()
	
	#uzzi.set_up([0],120,5,0.05,40,3,3.25,'medium_bullets')


func set_pistol()->void:
	pistol.set_up([0],150,5,0.45,7,1.5,1.8,'small_bullets')
	pistol.set_knock_power(600)
	pistol.set_visual_variables("res://Resources/pistol33x21.png",Vector2(10,10),Vector2(0,-2))
	pistol.add_global_entry('pistol_item')
	pistol_item.set_up(1,"res://Resources/pistol33x21.png",'pistol_item','weapon')
	pistol_item.add_to_loot_table1(1,0,40)
	pistol.set_sound("res://Resources/pistol.wav","res://Resources/pistol_reload.mp3")
func set_ak47()->void:
	ak47.set_up([0],500,7,0.1,30,4,2.85,'medium_bullets')
	ak47.set_knock_power(800)
	ak47.set_visual_variables("res://Resources/ak-47.png",Vector2(30,30),Vector2(-4,-15))
	ak47.add_global_entry('ak47_item')
	ak47_item.set_up(1,"res://Resources/ak-47.png",'ak47_item','weapon')
	ak47_item.add_to_loot_table1(1,0,20)
	ak47.set_sound("res://Resources/pistol.wav","res://Resources/pistol_reload.mp3")
func set_shotgun()->void:
	shotgun.set_up([0,-5,5,10,-10],125,8,0.65,25,4.1,20,'shotgun_bullets',)
	shotgun.set_knock_power(700)
	shotgun.set_visual_variables("res://Resources/shotgun.png",Vector2(25,25),Vector2(-5,-10),Vector2(0,-1))
	shotgun.add_global_entry('shotgun_item')
	shotgun_item.set_up(1,"res://Resources/shotgun.png",'shotgun_item','weapon')
	shotgun_item.add_to_loot_table1(1,0,25)
	shotgun.set_sound("res://Resources/shotgun_shot.wav","res://Resources/shotgun_reload.wav")

func set_minigun()->void:
	minigun.set_up([1,0,-1],165,4,0.05,99,6,3,'small_bullets')
	minigun.set_knock_power(160)
	minigun.set_visual_variables("res://Resources/minigun.png",Vector2(25,25),Vector2(0,-15),Vector2(0,0))
	minigun.add_global_entry('minigun_item')
	minigun_item.set_up(1,"res://Resources/minigun.png",'minigun_item','weapon')
	minigun_item.add_to_loot_table1(1,0,5)
	minigun.set_sound("res://Resources/minigun.wav")

func set_sniper()->void:
	sniper.set_up([0],1000,25,2,12,3,20,'sniper_bullets')
	sniper.set_visual_variables("res://Resources/sniper33x8.png",Vector2(20,8),Vector2(-3,0))
	sniper.add_global_entry('sniper_item')
	sniper_item.set_up(1,"res://Resources/sniper33x8.png",'sniper_item','weapon')
	sniper_item.add_to_loot_table1(1,0,15)
	sniper.set_knock_power(1400)
	sniper.set_sound("res://Resources/sniper.wav","res://Resources/sniper_reload.wav")

func set_uzzi()->void:
	uzzi.set_up([0],185,4,0.05,45,2,3,'small_bullets')
	uzzi.set_visual_variables('res://Resources/uzi.png',Vector2(10,10),Vector2(0,-5))
	uzzi.add_global_entry('uzzi_item')
	uzzi_item.set_up(1,'res://Resources/uzi.png','uzzi_item','weapon')
	uzzi_item.add_to_loot_table1(1,0,10)
	uzzi.set_knock_power(110)
	uzzi.set_sound("res://Resources/uzzi_shoot.wav","res://Resources/uzzi_reload.wav")

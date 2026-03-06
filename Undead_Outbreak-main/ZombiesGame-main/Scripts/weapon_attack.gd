extends Resource
class_name weapon_attack


var bullet_direction : Array[float]
var bullet_damage : float
var bullet_length : float
var direction : Vector2




func Set_up(wp : weapon,dir : Vector2)->void:
	bullet_direction=wp.bullet_direction
	bullet_damage=wp.bullet_damage
	bullet_length=wp.bullet_length
	direction=dir

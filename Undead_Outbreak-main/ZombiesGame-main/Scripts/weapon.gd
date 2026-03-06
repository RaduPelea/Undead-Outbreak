extends Resource
class_name weapon

var bullet_direction : Array[float]
var bullet_length : float
var bullet_damage : float
var cool_down : float
var mag_size : int
var reload_time : float
var recoil_force : float
var knock_power : float
var bullet_type : String
var sprite : String
var size : Vector2
var offset : Vector2
var b_component_pos : Vector2
var type : String
var shoot_sound : String
var reload_sound : String


func set_up(b_dir : Array[float],b_length : float,b_damage : float,cool_down_ : float,mag_size_ : int,reload_time_ : float,recoil_force_ : float,bullet_type_ : String ='')->void:
	bullet_direction=b_dir
	bullet_length=b_length
	bullet_damage=b_damage
	cool_down=cool_down_
	mag_size=mag_size_
	reload_time=reload_time_
	recoil_force=recoil_force_
	bullet_type=bullet_type_

func set_knock_power(val : float)->void:
	knock_power=val


func set_visual_variables(sprite_ : String ='',size_ : Vector2 = Vector2(16,16),offset_ : Vector2=Vector2.ZERO,b_component_ : Vector2 = Vector2.ZERO)->void:
	sprite=sprite_
	size=size_
	offset=offset_
	b_component_pos=b_component_


func set_sound(shoot_ : String = '',reload_ : String= '')->void:
	shoot_sound=shoot_
	reload_sound=reload_

func get_attack(dir : Vector2)->weapon_attack:
	var q : weapon_attack = weapon_attack.new()
	q.Set_up(self,dir)
	return q

func add_global_entry(type_ : String)->void:
	Data.weapons[type_]=self
	type=type_

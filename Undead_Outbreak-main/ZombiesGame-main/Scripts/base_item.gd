extends Resource
class_name  base_item
var max_quantity : int
var image : String =''
var type : String
var utility : String
var add_value : int



func set_up(max_qu : int,img : String,type_ : String = '',utility_ : String = '',add_value_ : int = 0)->void:
	max_quantity=max_qu
	image=img
	type=type_
	utility=utility_
	add_value=add_value_

func add_to_loot_table1( qu : int,st : int , dr : int )->void:
	Data.loot_table1[self]=[qu,st,dr]
func add_to_loot_table2( qu : int,st : int , dr : int )->void:
	Data.loot_table2[self]=[qu,st,dr]
func add_to_loot_table3( qu : int,st : int , dr : int )->void:
	Data.loot_table3[self]=[qu,st,dr]

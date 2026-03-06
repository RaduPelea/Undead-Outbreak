extends StaticBody2D

@export var number_of_items : int

@export var cast_shadow : bool = false


@onready var inv = $Control/Inventory
@export var crate_scale : float = 1
func _ready():
	if !cast_shadow:
		$LightOccluder2D.queue_free()
	if randi()%2:
		queue_free()
	
	$Sprite2D.scale=Vector2(crate_scale,crate_scale)
	$CollisionShape2D.scale=Vector2(crate_scale,crate_scale)
	global_rotation=0
	var arr : Array[Array]
	for j in Data.loot_table2.keys():
			arr.push_back([j,Data.loot_table2[j]])
	arr.shuffle()
	
	for i in number_of_items: 
		var x = randi()%100
		if(arr.front()[1][1]<=x and arr.front()[1][2]>=x):
			inv.add_item(arr.front()[0],arr.front()[1][0])
		arr.pop_front()
		pass
var p_pos : Vector2


func _process(delta):
	if inv.visible and p_pos!=Global.player.global_position:
		inv.hide_inventory()

func TakeDamage(damage : float)->void:
	$Health_component.TakeDamage(damage)

func toggle_inventory()->void:
	if inv.visible==false:
		p_pos = Global.player.global_position
		inv.show_inventory()
		await  get_tree().create_timer(10.0).timeout
		if inv.visible:
			inv.hide_inventory()
	else:
		inv.hide_inventory()


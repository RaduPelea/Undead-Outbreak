extends Sprite2D


var sprites : Array = [
	preload("res://Resources/blood1.png"),
	preload("res://Resources/blood2.png"),
	preload("res://Resources/blood3.png")
	
]


func _ready():
	texture=sprites[randi()%sprites.size()]
	flip_h=randi()%2
	var tw :Tween = create_tween()
	tw.tween_property(self,'modulate',Color(1,1,1,0),15)
	await tw.finished
	queue_free()

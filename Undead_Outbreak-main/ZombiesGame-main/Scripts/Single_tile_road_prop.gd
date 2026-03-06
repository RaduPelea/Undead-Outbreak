extends Sprite2D


func _ready():
	var i : int = randi()%Global.single_prop_road_tiles.size()
	texture=Global.single_prop_road_tiles[i]
	flip_h=randi()%2

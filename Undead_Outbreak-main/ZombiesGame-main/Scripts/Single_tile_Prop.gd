extends Sprite2D


@export var sprite_folder : Array[NodePath]


func _ready():
	var i : int = randi()%Global.single_prop_tiles.size()
	texture=Global.single_prop_tiles[i]
	flip_h=randi()%2
	if texture.get_size().x==16:
		scale=Vector2(1,1)
		texture_filter=CanvasItem.TEXTURE_FILTER_NEAREST
		material=null
		modulate=Color(1,1,1)
	

extends Line2D


var target : Vector2

var length : float

var once : bool = true

var speed : float = 1400

var direction : Vector2

var min_length : float = 16
var max_length : float = 8

var delete_dist : float = 5 


func _ready():
	length=randi_range(Vector2.ZERO.distance_to(target)/min_length,Vector2.ZERO.distance_to(target)/max_length )
	direction = target.normalized()
	var k_max : float = target.x/direction.x-length-5
	await get_tree().create_timer(k_max/speed).timeout
	queue_free()
	
	
var k : float = length

var elaps : float
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	clear_points()
	k+=delta*speed
	elaps+=delta
	add_point(Vector2.ZERO + k*direction)
	add_point((length+k)*direction)

	


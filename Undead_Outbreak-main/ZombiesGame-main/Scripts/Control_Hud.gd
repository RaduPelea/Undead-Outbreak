extends Control


func _process(delta):
	process_shake()
	
	


var shake_is_started : bool = false
var shake_strength : float =0
func process_shake()->void:
	if !shake_is_started:
		return
	position=Vector2(randf_range(-shake_strength,shake_strength),randf_range(-shake_strength,shake_strength))


func shake(duration : float,strength : float)->void:
	shake_is_started=true
	shake_strength=strength
	await  get_tree().create_timer(duration).timeout
	shake_is_started=false
	position=Vector2.ZERO

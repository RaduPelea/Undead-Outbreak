extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("escape"):
		visible = !visible
		get_tree().paused= !get_tree().paused

func _on_back_button_up():
	get_tree().paused= false
	visible = false


func _on_quit_button_up():
	get_tree().paused= false
	get_tree().change_scene_to_file('res://Scenes/main_menu.tscn')



func _on_save_game_button_up():
	SaveSystem.save_data()

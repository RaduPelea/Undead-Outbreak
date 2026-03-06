extends Node2D



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_back_button_up():
	get_tree().change_scene_to_packed(load("res://Scenes/main_menu.tscn"))


func _on_difficulty_button_up():
	$VBoxContainer/MarginContainer/Difficulty/Node2D.visible=!$VBoxContainer/MarginContainer/Difficulty/Node2D.visible


func _on_easy_button_up():
	Global.dificulty_divider=2
	$VBoxContainer/MarginContainer/Difficulty/Node2D.visible=false

func _on_normal_button_up():
	Global.dificulty_divider=3
	$VBoxContainer/MarginContainer/Difficulty/Node2D.visible=false

func _on_hard_button_up():
	Global.dificulty_divider=4
	$VBoxContainer/MarginContainer/Difficulty/Node2D.visible=false

func _on_play_button_up():
	get_tree().change_scene_to_packed(load("res://Scenes/game.tscn"))

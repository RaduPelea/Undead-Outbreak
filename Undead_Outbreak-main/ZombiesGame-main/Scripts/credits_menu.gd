extends Node2D




func _on_back_button_up():
	get_tree().change_scene_to_packed(load("res://Scenes/main_menu.tscn"))

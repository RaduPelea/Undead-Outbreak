extends Node2D

#var new_game_menu = preload("res://Scenes/new_game_menu.tscn")


func _on_new_game_button_up():
	SaveSystem.destroy_save_file()
	get_tree().change_scene_to_packed(load("res://Scenes/new_game_menu.tscn"))


func _on_options_button_up():
	get_tree().change_scene_to_packed(load("res://Scenes/options.tscn"))


func _on_credits_button_up():
	get_tree().change_scene_to_packed(load("res://Scenes/credits_menu.tscn"))


func _on_exit_button_up():
	get_tree().quit()


func _on_continue_pressed():
	get_tree().change_scene_to_packed(load('res://Scenes/game.tscn'))


func _on_help_pressed():
	$ColorRect/Help_Menu.visible=!$ColorRect/Help_Menu.visible

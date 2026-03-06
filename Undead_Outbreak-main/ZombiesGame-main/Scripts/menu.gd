extends Control


var game = preload('res://Scenes/game.tscn')


func _ready():
	update_graphics_button()


func _on_start_button_pressed():
	get_tree().change_scene_to_packed(game)


func _on_exit_button_pressed():
	get_tree().quit()


func _on_options_button_pressed():
	$VBoxContainer/OptionsButton/Settings.visible=!$VBoxContainer/OptionsButton/Settings.visible


func _on_line_edit_text_submitted(new_text):
	Global.dificulty_divider=int(new_text)



func _on_high_graphics_pressed():
	if Global.high_graphics:
		Global.high_graphics=false
		$VBoxContainer/OptionsButton/Settings/HighGraphics.text='Off'
	else:
		Global.high_graphics=true
		$VBoxContainer/OptionsButton/Settings/HighGraphics.text='On'


func update_graphics_button()->void:
	if Global.high_graphics:
		$VBoxContainer/OptionsButton/Settings/HighGraphics.text='On'
	else:
		$VBoxContainer/OptionsButton/Settings/HighGraphics.text='On'


func _on_volume_edit_text_submitted(new_text):
	if int(new_text)>120:
		return
	Global.volume=int(new_text)-100

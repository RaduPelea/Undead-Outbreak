extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	var vsync_label := $VBoxContainer/MarginContainer/Vsync/Label
	var graphics_label :=$VBoxContainer/MarginContainer5/Graphics/Label
	var show_fps_label :=$VBoxContainer/MarginContainer3/Showfps/Label
	var full_screen_lable :=$VBoxContainer/MarginContainer4/FullScreen/Label
	set_label_on_off(Global.Vsync,vsync_label)
	set_label_on_off(Global.high_graphics,graphics_label)
	set_label_on_off(Global.show_fps,show_fps_label)
	set_label_on_off(Global.full_screen,full_screen_lable)
	set_window()

func set_window()->void:
	#if Global.full_screen:
	#	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	#else:
	#	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	if Global.Vsync:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
	else:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)



func set_label_on_off(val : bool , lab : Label)->void:
	if val:
		lab.text='On'
	else:
		lab.text='Off'


func _on_back_button_up():
	get_tree().change_scene_to_packed(load("res://Scenes/main_menu.tscn"))
	

func _on_vsync_button_up():
	var l : Label = $VBoxContainer/MarginContainer/Vsync/Label
	if l.text==str("On") :
		l.text=str("Off")
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)
		Global.Vsync = false
	else :
		l.text=str("On")
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
		Global.Vsync = true


func _on_graphics_button_up():
	var l : Label = $VBoxContainer/MarginContainer5/Graphics/Label
	if l.text=="On" :
		l.text="Off"
		Global.high_graphics = false
	else:
		l.text="On"
		Global.high_graphics = true
	


func _on_showfps_button_up():
	var l : Label = $VBoxContainer/MarginContainer3/Showfps/Label
	if l.text == "Off":
		l.text = "On"
		Global.show_fps = true
	else :
		l.text = "Off"
		Global.show_fps = false




func _on_full_screen_button_up():
	var l : Label = $VBoxContainer/MarginContainer4/FullScreen/Label
	if l.text=='on':
		l.text='off'
		Global.full_screen=false
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MAXIMIZED)
	else:
		l.text='on'
		Global.full_screen=true
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)

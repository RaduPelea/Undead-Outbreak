extends VisibleOnScreenNotifier2D



func _ready():
	get_parent().process_mode=Node.PROCESS_MODE_DISABLED

func _on_screen_entered():
	get_parent().process_mode=Node.PROCESS_MODE_ALWAYS

func _on_screen_exited():
	get_parent().process_mode=Node.PROCESS_MODE_DISABLED


extends StaticBody2D


func _on_timer_timeout():
	var x := randi()%2
	#print(x)s
	if x == 0 : 
		$rain.emitting = true
	else :
		$rain.emitting = false

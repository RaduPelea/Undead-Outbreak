extends StaticBody2D

var state = "day"

var change_state : bool = false
var length_of_day = 450
var length_of_night = 450 # sec
var seconds = 6*3600
var h
var m
var ok : bool
var afisare : String
func _ready():
	if state == "day":
		$ColorRect.color.a=0
	else :
		$ColorRect.color.a=150

func _on_timer_timeout():
	if state == "day" :
		state = "night"
		change_to_night()
	elif state == "night" :
		state = "day"
		change_to_day()

func _process(delta):
	display_time()
	pass
	#if change_state==true :
	#	change_state=false
	#	if state == "day" :
	#		change_to_day()
	#	else :
	#		change_to_night()


func change_to_day()->void:
	$AnimationPlayer.play("night_to_day")
	$Timer.wait_time = length_of_day
	$Timer.start()


func change_to_night()->void:
	$AnimationPlayer.play("day_to_night")
	$Timer.wait_time = length_of_night
	$Timer.start()


func _on_clock_timer_timeout():
	seconds+=96
	seconds%=86400
	$clock_timer.start()
	
func display_time():
	var secaux = seconds
	h=secaux/3600
	secaux-=h*3600
	m=secaux/60
	if h > 12 :
		ok = true
		h-=12
	else :
		ok = false
	afisare = str('')
	if h < 10 :
		afisare+=str("0")
	afisare+=str(h)+str(" : ")
	if(m<10):
		afisare+=str("0")
	afisare+=str(m)+str(" ")
	if ok == true :
		afisare+=str("PM")
	else :
		afisare+=str("AM")
	$"../../../../HUD/Hud/clock".text=afisare
	#print("  ")
	#print(m)

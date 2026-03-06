extends Node
class_name  Movement_component

@export var speed : float
@export var parent : CharacterBody2D
var motion : Vector2

@export var audio : AudioStreamPlayer2D

var walk  = preload("res://Resources/walking.wav")


func add_movement(d : Vector2)->void:
	motion += d
func multiply_movement(d : float)->void:
	motion *= d
func simulate_frame()->void:
	parent.velocity=motion
	parent.move_and_slide()
	if motion.x!=0:
		motion.x/=6
	if motion.y!=0:
		motion.y/=6
	
	if audio==null:
		return
	
	if motion != Vector2.ZERO and audio.playing==false:
		Global.audio_listener.global_position=parent.global_position
		audio.stream=walk
		audio.play()

	if motion.length()>12:
		audio.volume_db=4+Global.volume
	else:
		audio.volume_db=Global.volume
	if motion==Vector2.ZERO and audio.playing==true:
		audio.stop()




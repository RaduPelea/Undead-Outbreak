extends Area2D
class_name Visibility_component

@export var parent : CharacterBody2D


var visibility_check_array : Dictionary

var del_queue : Array[Node2D]
var add_queue : Array[Node2D]

@export var points_to_check : Array[Vector2]

func _ready():
	$RayCast2D.add_exception(parent)

func _on_body_entered(body):
	if body==parent:
		return
	if body.is_in_group('alive'):
		add_queue.push_back(body)
		
	
func _on_body_exited(body):
	if body.is_in_group('alive'):
		del_queue.push_back(body)
		var tw :Tween = create_tween()
		tw.tween_property(body,'modulate',Color(body.modulate.r,body.modulate.g,body.modulate.b,0),0.1)
		await tw.finished
		if body!=null:
			body.visible=false

func _on_timer_timeout():
	show_visible()





func show_visible()->void:
	$RayCast2D.position=Vector2.ZERO
	$RayCast2D.target_position=Vector2(320,0)
	$RayCast2D.rotation_degrees=0
	
	for i in del_queue:
		visibility_check_array.erase(i)
	for i in add_queue:
		visibility_check_array[i]=false
	
	add_queue.clear()
	del_queue.clear()
	
	
	
	
	for i in visibility_check_array.keys():
		visibility_check_array[i]=false
	
	
	
	for j in points_to_check:
		$RayCast2D.position=j
		for i in range(0,360,1):
			$RayCast2D.rotation_degrees=i
			$RayCast2D.force_raycast_update()
			var r : Object = $RayCast2D.get_collider()
			if r!=null and visibility_check_array.has(r):
				visibility_check_array[r]=true
	
	
	for i in visibility_check_array.keys():
		if ! visibility_check_array.has(i):
			continue
		
		if i!=null and visibility_check_array[i]==true and i.visible==false:
			
			i.visible=true
			
			var tw :Tween = create_tween()
			tw.tween_property(i,'modulate',Color(i.modulate.r,i.modulate.g,i.modulate.b,1),0.1)
		elif i!=null and visibility_check_array[i]==false and i.visible==true:
			var tw :Tween = create_tween()
			tw.tween_property(i,'modulate',Color(i.modulate.r,i.modulate.g,i.modulate.b,0),0.1)
			await  tw.finished
			i.visible=false

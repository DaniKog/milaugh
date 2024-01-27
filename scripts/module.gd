extends CharacterBody2D

signal entered_voicebox
signal exited_voicebox


var mouseInside = false
var dragging = false
var insideVoicebox = false


func _input(event):
	if event is InputEventMouseButton:
		if event.is_pressed() && mouseInside:
			dragging = true
		else:
			print("stopped?")
			dragging = false
			
			if !insideVoicebox:
				queue_free()
			
	if event is InputEventMouseMotion && dragging:
		position = event.position - Vector2(10, 10)


func _physics_process(delta):
	move_and_slide()


func _on_mouse_entered():
	print("enter")
	mouseInside = true


func _on_mouse_exited():
	print("exit")
	mouseInside = false


func _on_entered_voicebox():
	insideVoicebox = true
	pass # Replace with function body.


func _on_exited_voicebox():
	insideVoicebox = false
	pass # Replace with function body.

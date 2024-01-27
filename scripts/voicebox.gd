extends Control

signal mouse_entered_voicebox
signal mouse_exited_voicebox


var mouseInside = false


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	

func _on_mouse_entered():
	print("mouse entered voicebox")
	mouse_entered_voicebox.emit()
	pass # Replace with function body.


func _on_mouse_exited():
	print("mouse exited voicebox")
	mouse_exited_voicebox.emit()
	pass # Replace with function body.

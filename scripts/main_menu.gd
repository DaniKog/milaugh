extends Control

signal start_game

func _on_button_play_pressed():
	emit_signal("start_game")
	UiSound.play_UI_Click()
	pass # Replace with function body.

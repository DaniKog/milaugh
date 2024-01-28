extends Control

signal restart_game

const RESULT_SUCCESS = "All in a day's work for the Mi-Laugh Technician!"
const RESULT_FAILURE = "I should probably work harder to understand my customers better..."
const SUCCESS_THRESHOLD = 2

@onready var globals  = get_node("/root/Globals")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_visibility_changed():
	if visible:
		# Set content based on results
		%label_result.text = "That's {num} satisfied customers!".format({ "num": globals.total_score })
		if globals.total_score >= SUCCESS_THRESHOLD:
			%label_summary.text = RESULT_SUCCESS
		else:
			%label_summary.text = RESULT_FAILURE
		
	
	pass # Replace with function body.


func _on_button_next_pressed():
	emit_signal("restart_game")
	pass # Replace with function body.

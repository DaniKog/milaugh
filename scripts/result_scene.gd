extends Control

signal restart_game

const RESULT_SUCCESS = "All in a day's work for the Mi-Laugh Atelier!"
const RESULT_NEUTRAL = "That wasn't too bad. I'll do even better tomorrow!"
const RESULT_FAILURE = "I should probably work harder to understand my customers better"
const SUCCESS_THRESHOLD = 5
const NEUTRAL_THRESHOLD = 10

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
		%label_result.text = "That's {num} happy customers!".format({ "num": globals.happy_customers })
		if globals.total_score <= SUCCESS_THRESHOLD:
			%label_summary.text = RESULT_SUCCESS
		elif globals.total_score <= NEUTRAL_THRESHOLD:
			%label_summary.text = RESULT_NEUTRAL
		else:
			%label_summary.text = RESULT_FAILURE
		
	
	pass # Replace with function body.


func _on_button_next_pressed():
	emit_signal("restart_game")
	pass # Replace with function body.
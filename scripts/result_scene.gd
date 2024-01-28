extends Control

signal restart_game

const RESULT_SUCCESS = "All in a day's work for the Mi-Laugh Atelier!"
const RESULT_NEUTRAL = "That wasn't too bad. I'll do even better tomorrow!"
const RESULT_FAILURE = "I should probably work harder to understand my customers better"
const SUCCESS_THRESHOLD = 3
const NEUTRAL_THRESHOLD = 1

var happy_robot = preload("res://art/robot_happy.png")
var meh_robot = preload("res://art/robot_meh.png")
var sad_robot = preload("res://art/robot_sad.png")

@onready var globals  = get_node("/root/Globals")


func _on_visibility_changed():
	if visible:
		# Set content based on results
		%label_result.text = "That's {num} happy customers!".format({ "num": globals.happy_customers })
		if globals.happy_customers >= SUCCESS_THRESHOLD:
			%label_summary.text = RESULT_SUCCESS
			%graphic_result.texture = happy_robot
		elif globals.happy_customers >= NEUTRAL_THRESHOLD:
			%label_summary.text = RESULT_NEUTRAL
			%graphic_result.texture = meh_robot
		else:
			%label_summary.text = RESULT_FAILURE
			%graphic_result.texture = sad_robot


func _on_button_next_pressed():
	emit_signal("restart_game")

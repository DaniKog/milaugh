extends Node

var last_robot_index = -1
#var robot_rsrc:Array[Robot]
var robot_rsrc:Array[Robot] = [
		load("res://resources/robots/antoinette.tres"),
		load("res://resources/robots/jester.tres"),
		load("res://resources/robots/mcrapper.tres"),
		load("res://resources/robots/siri.tres"),
]

# Called when the node enters the scene tree for the first time.
func _ready():
	#for filePath in DirAccess.get_files_at("res://resources/robots/"):
	#	if filePath.get_extension() == "tres":  
	#		robot_rsrc.append(load("resources/robots/"+filePath) )
	# invite the robot
	invite_robot()
	pass # Replace with function body.

func invite_robot():
	# choose a random robot
	var rand_robot_idx = randi_range(1,4)
	while rand_robot_idx == last_robot_index:
		rand_robot_idx = randi_range(1,4)
	var robot :Robot = robot_rsrc[rand_robot_idx-1]
	%label_robot.text = robot.name
	%texture_rect_robot.texture = robot.image
	%text_robot.text = robot.description
	%label_pitch_value.text = str(robot.pitch)
	%label_speed_value.text = str(robot.speed)
	%label_volume_value.text = str(robot.volume)
	$"../ResultScreen/Robot_Name".text = robot.name
	$"../ResultScreen/Robot_Icon".texture = robot.image
	$"../ResultScreen/Text_Fail".text = robot.fail_text
	$"../ResultScreen/Text_Fail".visible = 0
	$"../ResultScreen/Text_Average".text = robot.avg_text
	$"../ResultScreen/Text_Success".text = robot.success_text
	$"../ResultScreen/Text_Success".visible = 0
	last_robot_index = rand_robot_idx
	pass

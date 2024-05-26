extends Node2D

@onready var UISound = $UiSoundAudio
var clickSound = load("res://audio/UI/UIClick.ogg")
var installPartUI = [
	load("res://audio/UI/UInstallPart-001.ogg"),
	load("res://audio/UI/UInstallPart-002.ogg"),
	load("res://audio/UI/UInstallPart-003.ogg"),
	load("res://audio/UI/UInstallPart-004.ogg")
]

var nextRobotUI = [
	load("res://audio/UI/UINextRobot-001.ogg"),
	load("res://audio/UI/UINextRobot-002.ogg"),
]

var ui_mix = {
	"click" : 0,
	"InstallPart" : -3,
	"nextRobotUI" : 0
}

func play_UI_Click():
	UISound.volume_db = ui_mix["click"]
	UISound.pitch_scale = 1.0
	UISound.stream = clickSound
	var pitchAndomization = randf_range(-0.5, 0.5)
	UISound.pitch_scale += pitchAndomization
	UISound.play()
	
func play_UI_NextRobot():
	UISound.volume_db = ui_mix["nextRobotUI"]
	UISound.pitch_scale = 1.0
	var randomIndex = randi_range(0, len(nextRobotUI)-1)
	UISound.stream = nextRobotUI[randomIndex]
	var pitchAndomization = randf_range(-0.2, 0.2)
	UISound.pitch_scale += pitchAndomization
	UISound.play()

func play_UI_InstallPart():
	UISound.volume_db = ui_mix["InstallPart"]
	UISound.pitch_scale = 1.0
	var randomIndex = randi_range(0, len(installPartUI)-1)
	UISound.stream = installPartUI[randomIndex]
	var pitchAndomization = randf_range(-0.2, 0.2)
	UISound.pitch_scale += pitchAndomization
	UISound.play()

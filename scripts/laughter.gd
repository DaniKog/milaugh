extends Node2D
#naming variables
var maxVariations = 2
@onready var globals  = get_node("/root/Globals")
@onready var volume = globals.laughterVolume.Medium

@onready var speed = globals.laughterSpeed.Normal
var pitch = 1

@onready var audioPlayer = $LaughterSound
@onready var laugh = load("res://audio/Laugh_Ha_High_Fast-001.wav")
@onready var laughBus = AudioServer.get_bus_index("Laugh")
#@export AudioStream streams: Array  
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func Play():
	Stop()
	UpdateLaughSound()
	audioPlayer.play()

func Stop():
	audioPlayer.stop()

func SetValue(myType, value):
	match myType:
		globals.LaughParameter.Pitch:
			pitch = value*0.5
			if pitch == 0:
				pitch = .3
		globals.LaughParameter.Speed:
			speed = value
		globals.LaughParameter.Volume:
			volume = value
		_:
			print('Laugh Paramter not support')
	UpdateLaughSound()
	
func UpdateLaughSound():
	var formatString = "res://audio/Laugh_Ha_{intensity}_{speed}-00{variation}.wav"
	var sample_volume = volume
	if sample_volume > 3 :
		sample_volume = 3
	if sample_volume < 1 :
		sample_volume = 1
		
	var sample_speed = speed
	if sample_speed > 3 :
		sample_speed = 3
	if sample_speed < 1 :
		sample_speed = 1
		
	var laughSoundPath = formatString.format({"intensity": globals.laughterVolume.keys()[sample_volume],
	 "speed": globals.laughterSpeed.keys()[sample_speed], "variation" : 1})
	laugh = load(str(laughSoundPath))
	print(str(laughSoundPath))
	print(globals.laughterSpeed.keys()[speed])
	print(globals.laughterVolume.keys()[volume])
	print(pitch)
	
	audioPlayer.stream = laugh
	var effect = AudioServer.get_bus_effect(1, 0)
	if speed == 4:
		effect.drive = 1
	else:
		effect.drive = 0
		


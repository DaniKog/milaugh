extends Node2D

# For the sake of simplicity, all values have the same bounds
# based on the size of the sound variation arrays (5).
const MIN_VALUE = 1
const MAX_VALUE = 5


#naming variables
var maxVariations = 2
@onready var globals  = get_node("/root/Globals")
@onready var volume = globals.laughterVolume.Medium

@onready var speed = globals.laughterSpeed.Normal
var pitch = 3

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
			pitch = value
			pitch = max(MIN_VALUE, min(MAX_VALUE, pitch))
		globals.LaughParameter.Speed:
			speed = value
			speed = max(MIN_VALUE, min(MAX_VALUE, speed))
		globals.LaughParameter.Volume:
			volume = value
			volume = max(MIN_VALUE, min(MAX_VALUE, volume))
		_:
			print('Laugh Paramter not support')
	UpdateLaughSound()

func AddValue(myType, value):
	match myType:
		globals.LaughParameter.Pitch:
			pitch += value
			pitch = max(MIN_VALUE, min(MAX_VALUE, pitch))
		globals.LaughParameter.Speed:
			speed += value
			speed = max(MIN_VALUE, min(MAX_VALUE, speed))
		globals.LaughParameter.Volume:
			volume += value
			volume = max(MIN_VALUE, min(MAX_VALUE, volume))
		_:
			print('Laugh Paramter not support')
	UpdateLaughSound()
	
func UpdateLaughSound():
	var formatString = "res://audio/Laugh_Ha_{intensity}_{speed}-00{variation}.wav"
		
	var laughSoundPath = formatString.format({"intensity": globals.laughterVolume.keys()[volume-1],
	 "speed": globals.laughterSpeed.keys()[speed-1], "variation" : 1})
	laugh = load(str(laughSoundPath))

	audioPlayer.stream = laugh
	var pitchToSet = pitch*0.5 - 0.5
	if pitchToSet <= 0:
		pitchToSet += .3
	
	print(str(laughSoundPath))
	print(globals.laughterSpeed.keys()[speed-1])
	print(globals.laughterVolume.keys()[volume-1])
	print(pitch, "->", pitchToSet)
	audioPlayer.pitch_scale = pitchToSet
		


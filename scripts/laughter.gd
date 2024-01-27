extends Node2D
#naming variables
var maxVariations = 2
enum laughterIntensity {Low, Medium, High}
var intensity = laughterIntensity.Medium
enum laughterSpeed {Slow, Normal, Fast}
var speed = laughterSpeed.Normal
var pitch = 1
@onready var audioplayer = $LaughterSound
@onready var laugh = load("res://audio/Laugh_Ha_High_Fast-001.wav")
#@export AudioStream streams: Array  
# Called when the node enters the scene tree for the first time.
func _ready():
	var formatString = "res://audio/Laugh_Ha_{intensity}_{speed}-00{variation}.wav"
	var laughSoundPath = formatString.format({"intensity": laughterIntensity.keys()[intensity],
	 "speed": laughterSpeed.keys()[speed], "variation" : 1})
	laugh = load(str(laughSoundPath))
	audioplayer.stream = laugh
	
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func RaisePitch():
	pitch = pitch + 0.5
	print(pitch)
	
func LowerPitch():
	pitch = pitch - 0.5
	print(pitch)
	
func RaiseSpeed():
	speed = speed + 1
	print(laughterSpeed.keys()[speed])
	
func LowerSpeed():
	speed = speed - 1 
	print(laughterSpeed.keys()[speed])

func RaiseIntensity():
	intensity = intensity + 1
	print(intensity)
	
func LowerIntensity():
	intensity = intensity - 1 
	print(intensity)
	
func SetIntensity(intensity_index):
	intensity = intensity_index
	
func SetSpeed(speed_index):
	speed = speed_index
	
func SetPitch(pitch_number):
	pitch = pitch_number
	
func Play():
	audioplayer.play()

func Stop():
	audioplayer.stop()

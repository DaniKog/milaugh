extends Node
@onready var label = $Label
@onready var value = $Value
@onready var valueNumber = int(value.text)
@onready var laughterModule = $"../../../../../Laughter"
@onready var UpButton = $Up
@onready var DownButton = $Down

enum valueTpye {Pitch, Speed, Volume}
@export var myValueType = valueTpye.Pitch
# Called when the node enters the scene tree for the first time.
func _ready():
	UpButton.pressed.connect(self.ValueUp)
	DownButton.pressed.connect(self.ValueDown)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func ValueUp():
	valueNumber = valueNumber + 1
	value.text = str(valueNumber)
	RaiseVlaue()
	
func ValueDown():
	valueNumber = valueNumber - 1
	value.text = str(valueNumber)
	LowerVlaue()
	
func RaiseVlaue():
	match myValueType:
		valueTpye.Pitch:
			laughterModule.RaisePitch()
		valueTpye.Speed:
			laughterModule.RaiseSpeed()
		valueTpye.Volume:
			laughterModule.RaiseIntensity()
		_:
			print('This tool is not supported')
			
func LowerVlaue():
	match myValueType:
		valueTpye.Pitch:
			laughterModule.LowerPitch()
		valueTpye.Speed:
			laughterModule.LowerSpeed()
		valueTpye.Volume:
			laughterModule.LowerIntensity()
		_:
			print('This tool is not supported')

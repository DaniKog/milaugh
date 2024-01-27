extends Node
@onready var label = $Label
@onready var value = $Value
@onready var valueNumber = int(value.text)
@onready var laughterModule = $"../../../../../Laughter"
@onready var UpButton = $Up
@onready var DownButton = $Down

enum valueTpye {Pitch, Speed, Volume}
@onready var globals  = get_node("/root/Globals")
@export var myValueType = valueTpye.Pitch
# Called when the node enters the scene tree for the first time.
func _ready():
	UpButton.pressed.connect(self.ValueUp)
	DownButton.pressed.connect(self.ValueDown)
	valueNumber = int(value.text) -1
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func ValueUp():
	valueNumber = valueNumber + 1
	if valueNumber > 4:
		valueNumber = 4
	else:
		laughterModule.SetValue(myValueType, valueNumber)
	value.text = str(valueNumber+1)

	
func ValueDown():
	valueNumber = valueNumber - 1
	if valueNumber < 0:
		valueNumber = 0
	else:
		laughterModule.SetValue(myValueType, valueNumber)
	value.text = str(valueNumber+1)
	
	
func SetValue():
	match myValueType:
		valueTpye.Pitch:
			laughterModule.RaisePitch()
		valueTpye.Speed:
			laughterModule.RaiseSpeed()
		valueTpye.Volume:
			laughterModule.RaiseVolume()
		_:
			print('This tool is not supported')

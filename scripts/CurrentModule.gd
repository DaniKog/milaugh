extends GridContainer

@onready var pitchValue = $Current_P_Value
@onready var speedValue = $Current_S_Value
@onready var volumeValue = $Current_V_Value
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func SetPitch(value):
	pitchValue.text = str(value)

func SetSpeed(value):
	speedValue.text = str(value)
	
func SetVolume(value):
	volumeValue.text = str(value)

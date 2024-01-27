extends Resource
class_name ModuleData

@export var name: String
@export var description: String
@export var icon: Resource
@export var pitch: float
@export var speed: float
@export var volume: float

func _init(p_name = "", p_description = "", p_icon = null, p_pitch = 0, p_speed = 0, p_volume = 0):
	name = p_name
	description = p_description
	icon = p_icon
	pitch = p_pitch
	speed = p_speed
	volume = p_volume

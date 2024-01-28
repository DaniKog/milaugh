extends Node2D

@onready var audioPlayer = $AudioStreamPlayer2D
var musics = [
	load("res://music/milaugh_drunken_fly.ogg"),
	load("res://music/milaugh_factory_standard.ogg"),
]
# Called when the node enters the scene tree for the first time.
func _ready():
	var randeomIndex = randi() % 2 
	audioPlayer.stream = musics[randeomIndex]
	audioPlayer.play()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

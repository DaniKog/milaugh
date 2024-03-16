extends Node2D
@onready var laughmod = %laughter_module/Laughter/LaughterSound
@onready var audioPlayer = $AudioStreamPlayer2D
var ducked = false
var musics = [
	load("res://music/milaugh_drunken_fly.wav"),
	load("res://music/milaugh_factory_standard.ogg"),
]
# Called when the node enters the scene tree for the first time.
func _ready():
	var randomIndex = randi_range(0, 1)
	audioPlayer.stream = musics[randomIndex]
	#audioPlayer.play()
	#TODO Master the Music
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(laughmod.playing and !ducked):
		audioPlayer.volume_db = audioPlayer.volume_db - 12
		ducked = true
	if(!laughmod.playing and ducked):
		audioPlayer.volume_db = audioPlayer.volume_db + 12
		ducked = false
	pass

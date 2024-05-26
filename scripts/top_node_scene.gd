extends Node

var mainGameScene = preload("res://scenes/main_game_scene.tscn")
var mainGameSceneInstance

# Called when the node enters the scene tree for the first time.
func _ready():
	mainGameSceneInstance = mainGameScene.instantiate()
	mainGameSceneInstance.visible = false
	mainGameSceneInstance.end_game.connect(_on_main_game_scene_end_game)
	add_child(mainGameSceneInstance)
	pass # Replace with function body.

	
func _input(event):
	if(event.is_action_pressed("quit")):
		get_tree().quit(0)


func _on_main_menu_start_game():
	$main_menu.visible = false
	$story_scene.visible = true
	pass # Replace with function body.


func _on_story_scene_start_game():
	$story_scene.visible = false
	mainGameSceneInstance.visible = true
	pass # Replace with function body.


func _on_result_scene_restart_game():
	remove_child(mainGameSceneInstance)
	mainGameSceneInstance.queue_free()
	mainGameSceneInstance = mainGameScene.instantiate()
	mainGameSceneInstance.end_game.connect(_on_main_game_scene_end_game)
	add_child(mainGameSceneInstance)
	$result_scene.visible = false
	pass # Replace with function body.


func _on_main_game_scene_end_game():
	mainGameSceneInstance.visible = false
	$result_scene.visible = true
	pass # Replace with function body.

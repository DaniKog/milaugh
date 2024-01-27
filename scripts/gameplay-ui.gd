extends Control

const PREVIEW_LENGTH = 0.1

@onready var globals  = get_node("/root/Globals")

var modules = [
	load("res://resources/items/evil_monkey.tres"),
	load("res://resources/items/hot_sauce.tres"),
	load("res://resources/items/brass_horn.tres"),
	load("res://resources/items/moonshine.tres"),
	load("res://resources/items/whistle.tres"),
]

# Called when the node enters the scene tree for the first time.
func _ready():
	for module in modules:
		%item_list.add_item(module.name, module.icon)

func _on_item_list_item_clicked(index, at_position, mouse_button_index):
	# Add to active item list
	%active_item_list.add_item(modules[index].name, modules[index].icon)
	
	# Apply value changes
	%laughter_module/Laughter.AddValue(globals.LaughParameter.Pitch, modules[index].pitch)
	%laughter_module/Laughter.AddValue(globals.LaughParameter.Speed, modules[index].speed)
	%laughter_module/Laughter.AddValue(globals.LaughParameter.Volume, modules[index].volume)
	
	# Play preview of new sound
	%laughter_module/Laughter.Play()
	await get_tree().create_timer(PREVIEW_LENGTH).timeout
	%laughter_module/Laughter.Stop()

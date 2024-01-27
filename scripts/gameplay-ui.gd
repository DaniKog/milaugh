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
		%item_list.set_item_tooltip(-1, module.description)
		%item_list.set_item_tooltip_enabled(-1, true)

func _on_item_list_item_clicked(index, at_position, mouse_button_index):
	# Add to active item list
	%active_item_list.add_item(
		%item_list.get_item_text(index),
		%item_list.get_item_icon(index)
	)
	
	# Remove from available item list
	%item_list.remove_item(index)
	
	# If we've selected 3 items, stop further selections
	if %active_item_list.item_count >= 3:
		%button_launch.set_disabled(false)
		for i in range(%item_list.item_count):
			%item_list.set_item_disabled(i, true)
			
	
	
	# Apply value changes
	%laughter_module/Laughter.AddValue(globals.LaughParameter.Pitch, modules[index].pitch)
	%laughter_module/Laughter.AddValue(globals.LaughParameter.Speed, modules[index].speed)
	%laughter_module/Laughter.AddValue(globals.LaughParameter.Volume, modules[index].volume)
	
	# Play preview of new sound
	%laughter_module/Laughter.Play()
	await get_tree().create_timer(PREVIEW_LENGTH).timeout
	%laughter_module/Laughter.Stop()
	
	


func _on_button_launch_pressed():
	print("go big mode")
	pass # Replace with function body.

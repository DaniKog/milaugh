extends Control

const PREVIEW_LENGTH = 0.1

@onready var globals  = get_node("/root/Globals")
@onready var laughterModule = %laughter_module/Laughter
@onready var currentModelValues = $panel_frame/panel_laugh_module/CurrentModule
@onready var textDescriptionDisplay = $panel_frame/panel_object_description/text_description
var modules = [
	load("res://resources/items/evil_monkey.tres"),
	load("res://resources/items/brass_horn.tres"),
	load("res://resources/items/moonshine.tres"),
	load("res://resources/items/whistle.tres"),
	load("res://resources/items/cow_bell.tres"),
	load("res://resources/items/fax_machine.tres"),
]

# Called when the node enters the scene tree for the first time.
func _ready():
	for module in modules:
		%item_list.add_item(module.name, module.icon)
		%item_list.set_item_tooltip(-1, module.description)
		%item_list.set_item_tooltip_enabled(-1, true)
		

func _on_item_list_item_clicked(index, at_position, mouse_button_index):
	if mouse_button_index == 1:
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
		var pitchToShow = round(%laughter_module/Laughter.pitch*2)
		pitchToShow = max(%laughter_module/Laughter.MIN_VALUE, min(%laughter_module/Laughter.MAX_VALUE, pitchToShow))
		currentModelValues.SetPitch(pitchToShow)
		currentModelValues.SetSpeed(%laughter_module/Laughter.speed)
		currentModelValues.SetVolume(%laughter_module/Laughter.volume)


func _on_button_launch_pressed():
	laughterModule.Play()
	calculate_result()
	pass # Replace with function body.

func calculate_result():
	var diff:int = 0
	diff += int(%label_pitch_value.text) - int(%Current_P_Value.text)
	diff += int(%label_speed_value.text) - int(%Current_S_Value.text)
	diff += int(%label_volume_value.text) - int(%Current_V_Value.text)
	
	if (diff<=2):
		#success
		$panel_frame/ResultScreen/Text_Success.visible = 1
	elif (diff <=5):
		#average
		$panel_frame/ResultScreen/Text_Average.visible = 1
	else:
		#fail
		$panel_frame/ResultScreen/Text_Fail.visible = 1
	$panel_frame/ResultScreen.visible=1

func _on_item_list_item_selected(index):
	print(%item_list.get_item_text(index))
	pass # Replace with function body.

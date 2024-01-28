extends Control

const PREVIEW_LENGTH = 0.15
const NUMBER_OF_ROBOTS_TO_MAKE_LAUGH = 3
var currentCustomerIndex = 0
@onready var globals  = get_node("/root/Globals")
@onready var laughterModule = %laughter_module/Laughter
@onready var currentModelValues = $panel_frame/panel_laugh_module/CurrentModule
@onready var textDescriptionDisplay = $panel_frame/panel_object_description/text_description

#var item_rsrc:Array[Item]
var item_rsrc = [
	load("res://resources/items/brass_horn.tres"),
	load("res://resources/items/cow_bell.tres"),
	load("res://resources/items/evil_monkey.tres"),
	load("res://resources/items/fax_machine.tres"),
	load("res://resources/items/hot_sauce.tres"),
	load("res://resources/items/moonshine.tres"),
	load("res://resources/items/whistle.tres"),
	load("res://resources/items/whistle.tres"),
	load("res://resources/items/whistle.tres"),
	load("res://resources/items/whistle.tres"),
	load("res://resources/items/whistle.tres"),
]

# Called when the node enters the scene tree for the first time.
func _ready():
	for item in item_rsrc:
		var item_idx = %item_list.add_item(item.name, item.icon)
		%item_list.set_item_tooltip(item_idx, item.description)
		%item_list.set_item_tooltip_enabled(item_idx, true)
		%item_list.set_item_metadata(item_idx, item)
	#populate item list, copy the complete rsrc into item "metadata"
	#for filePath in DirAccess.get_files_at("res://resources/items/"):
	#	if filePath.get_extension() == "tres":  
	#		var item:Item = load("resources/items/"+filePath)
	#		var item_idx = %item_list.add_item(item.name, item.icon)
	#		%item_list.set_item_tooltip(item_idx, item.description)
	#		%item_list.set_item_tooltip_enabled(item_idx, true)
	#		%item_list.set_item_metadata(item_idx, item)


func _on_item_list_item_clicked(index, at_position, mouse_button_index):
	if mouse_button_index == 1:
		# Add to active item list
		var active_item_idx = %active_item_list.add_item(
			%item_list.get_item_text(index),
			%item_list.get_item_icon(index))
		%active_item_list.set_item_tooltip(active_item_idx,%item_list.get_item_tooltip(index))
		%active_item_list.set_item_tooltip_enabled(active_item_idx, true)
		%active_item_list.set_item_metadata(active_item_idx,%item_list.get_item_metadata(index))	
		
		# If we've selected 3 items, stop further selections
		if %active_item_list.item_count >= 3:
			%button_launch.set_disabled(false)
			for i in range(%item_list.item_count):
				%item_list.set_item_disabled(i, true)
				
		
		# Apply value changes
		%laughter_module/Laughter.AddValue(globals.LaughParameter.Pitch, %item_list.get_item_metadata(index).pitch)
		%laughter_module/Laughter.AddValue(globals.LaughParameter.Speed, %item_list.get_item_metadata(index).speed)
		%laughter_module/Laughter.AddValue(globals.LaughParameter.Volume, %item_list.get_item_metadata(index).volume)
		
		# Play preview of new sound
		%laughter_module/Laughter.Play()
		await get_tree().create_timer(PREVIEW_LENGTH).timeout
		%laughter_module/Laughter.Stop()

		currentModelValues.SetPitch(%laughter_module/Laughter.pitch)
		currentModelValues.SetSpeed(%laughter_module/Laughter.speed)
		currentModelValues.SetVolume(%laughter_module/Laughter.volume)

		# LASTLY Remove from available item list
		%item_list.remove_item(index)

func _on_next_robot_pressed():
	if currentCustomerIndex == NUMBER_OF_ROBOTS_TO_MAKE_LAUGH:
		# Go to End Screen
		pass
	else:
		#invite new robot
		$panel_frame/panel_laugh_module.invite_robot(randi_range(1,4))
		#hide results panel
		$panel_frame/ResultScreen/Text_Average.visible = 0
		$panel_frame/ResultScreen/Text_Success.visible = 0
		$panel_frame/ResultScreen/Text_Fail.visible = 0
		$panel_frame/ResultScreen.visible=0
		#clear active list
		%active_item_list.clear()
		#reenable items
		for i in range(%item_list.item_count):
					%item_list.set_item_disabled(i, false)
		#re-disable Launch button
		%button_launch.set_disabled(true)
		currentModelValues.SetPitch(0)
		currentModelValues.SetSpeed(0)
		currentModelValues.SetVolume(0)
		
		%laughter_module/Laughter.AddValue(globals.LaughParameter.Pitch,3)
		%laughter_module/Laughter.AddValue(globals.LaughParameter.Speed,3)
		%laughter_module/Laughter.AddValue(globals.LaughParameter.Volume,3)
func _on_laugh_again_pressed():
	laughterModule.Play()
	pass # Replace with function body.
func _on_button_launch_pressed():
	laughterModule.Play()
	calculate_result()
	pass # Replace with function body.

func calculate_result():
	currentCustomerIndex += 1
	var diff:int = 0
	diff += abs(int(%label_pitch_value.text) - int(%Current_P_Value.text))
	diff += abs(int(%label_speed_value.text) - int(%Current_S_Value.text))
	diff += abs(int(%label_volume_value.text) - int(%Current_V_Value.text))
	
	var pitch_result = $panel_frame/ResultScreen/ModulePicture/HBoxContainer/ResultScreen_Pitch
	var speed_result = $panel_frame/ResultScreen/ModulePicture/HBoxContainer/ResultScreen_Speed
	var volume_result = $panel_frame/ResultScreen/ModulePicture/HBoxContainer/ResultScreen_Volume
	
	pitch_result.text = ("P." + %Current_P_Value.text)
	speed_result.text = ("S." + %Current_S_Value.text)
	volume_result.text = ("V." + %Current_V_Value.text)
	if currentCustomerIndex == NUMBER_OF_ROBOTS_TO_MAKE_LAUGH:
		$panel_frame/ResultScreen/Next_Robot.text = "Finished"
	if (diff<=2):
		#success
		$panel_frame/ResultScreen/Result_Title.text = "Great Job!"
		$panel_frame/ResultScreen/Text_Success.visible = 1
	elif (diff <=5):
		#average
		$panel_frame/ResultScreen/Result_Title.text = "Good enough.."
		$panel_frame/ResultScreen/Text_Average.visible = 1
	else:
		#fail
		$panel_frame/ResultScreen/Result_Title.text = "..whut..how..why?"
		$panel_frame/ResultScreen/Text_Fail.visible = 1
	$panel_frame/ResultScreen.visible=1
	globals.total_score += diff
	pass

func _on_item_list_item_selected(index):
	print(%item_list.get_item_text(index))
	pass # Replace with function body.




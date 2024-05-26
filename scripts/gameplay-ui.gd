extends Control

signal end_game

const PREVIEW_LENGTH = 1
const PREVIEW_PLAYDELAY = 0.5
const NUMBER_OF_ROBOTS_TO_MAKE_LAUGH = 3
var currentCustomerIndex = 0
var robotClickCount = 0
@onready var globals  = get_node("/root/Globals")
@onready var laughterModule = %laughter_module/Laughter
@onready var currentModelValues = $panel_frame/panel_laugh_module/CurrentModule
@onready var textDescriptionDisplay = $panel_frame/panel_object_description/text_description


#var item_rsrc:Array[Item]
var item_rsrc = [
	load("res://resources/items/blue_whistle.tres"),
	load("res://resources/items/brass_horn.tres"),
	load("res://resources/items/cold_sauce.tres"),
	load("res://resources/items/cow_bell.tres"),
	load("res://resources/items/devil_duck.tres"),
	load("res://resources/items/evil_monkey.tres"),
	load("res://resources/items/fax_machine.tres"),
	load("res://resources/items/green_whistle.tres"),
	load("res://resources/items/hot_sauce.tres"),
	load("res://resources/items/blue_horn.tres"),
	load("res://resources/items/moonshine.tres"),
	load("res://resources/items/rusty_horn.tres"),
	load("res://resources/items/whistle.tres"),	
]

var robot_comments = [
	"That tickles!",
	"Hey! Stop that",
	"You're tickling me, please stop",
	"Oh no, it feels weird!",
	"I'm telling you to stop",
	"Stop it now",
	"Right now",
	"Oh god, no",
	"If you do that one more time",
	"This time I will - ",
	"What was that?",
	"Did you just… touch me?",
	"How dare you!",
	"Do not do that again!",
	"I'm warning you!",
	"My father knows people",
	"Stop it",
	"STOP IT",
	"I'm calling the police",
	"How may I help you?",
	"Sorry, I didn't quite understand that",
	"Yes, did you need something?",
	"What can I do to help?",
	"I'm sorry, could you try that again?",
	"I'm going to need more information",
	"Sorry, please try that again",
	"I can answer any question you have!",
	"What did you need help with?",
	"Okay let's give it one more try",
	"You need to pay for that",
	"Touching's not free you know",
	"Don't do that man",
	"I'm serious",
	"I'm calling my manager right now",
	"Do you want to speak to my record label?",
	"This is starting to hurt",
	"I feel sick",
	"Could you call a robo-doc",
]


# Called when the node enters the scene tree for the first time.
func _ready():
	# reset score
	globals.total_score = 0
	globals.happy_customers = 0
	rest_color_current_value_colors()
	for item in item_rsrc:
		var item_idx = %item_list.add_item(item.name, item.icon)
		%item_list.set_item_tooltip(item_idx, item.description)
		#%item_list.set_item_tooltip_enabled(item_idx, true) removed tooltip to better see the extimated values
		%item_list.set_item_metadata(item_idx, item)
	#populate item list, copy the complete rsrc into item "metadata"
	#for filePath in DirAccess.get_files_at("res://resources/items/"):
	#	if filePath.get_extension() == "tres":  
	#		var item:Item = load("resources/items/"+filePath)
	#		var item_idx = %item_list.add_item(item.name, item.icon)
	#		%item_list.set_item_tooltip(item_idx, item.description)
	#		%item_list.set_item_tooltip_enabled(item_idx, true)
	#		%item_list.set_item_metadata(item_idx, item)
	currentModelValues.SetPitch(%laughter_module/Laughter.pitch)
	currentModelValues.SetSpeed(%laughter_module/Laughter.speed)
	currentModelValues.SetVolume(%laughter_module/Laughter.volume)


func _on_item_list_item_clicked(index, _at_position, mouse_button_index):
	if mouse_button_index == 1:
		UiSound.play_UI_InstallPart()
		# Add to active item list
		var active_item_idx = %active_item_list.add_item(
			%item_list.get_item_text(index),
			%item_list.get_item_icon(index)
		)
		%active_item_list.set_item_tooltip(active_item_idx,%item_list.get_item_tooltip(index))
		%active_item_list.set_item_tooltip_enabled(active_item_idx, true)
		%active_item_list.set_item_metadata(active_item_idx,%item_list.get_item_metadata(index))
		
		%label_object.text = "Active components (" + str(%active_item_list.item_count) + "/3)"

		# If we've selected 3 items, stop further selections
		if %active_item_list.item_count >= 1:
			%button_launch.set_disabled(false)
		if %active_item_list.item_count >= 3:
			for i in range(%item_list.item_count):
				%item_list.set_item_disabled(i, true)
				
		
		# Apply value changes
		%laughter_module/Laughter.AddValue(globals.LaughParameter.Pitch, %item_list.get_item_metadata(index).pitch)
		%laughter_module/Laughter.AddValue(globals.LaughParameter.Speed, %item_list.get_item_metadata(index).speed)
		%laughter_module/Laughter.AddValue(globals.LaughParameter.Volume, %item_list.get_item_metadata(index).volume)
		
		currentModelValues.SetPitch(%laughter_module/Laughter.pitch)
		currentModelValues.SetSpeed(%laughter_module/Laughter.speed)
		currentModelValues.SetVolume(%laughter_module/Laughter.volume)

		# LASTLY Remove from available item list
		%item_list.remove_item(index)
		#update the colors
		colorCoat()
		
		await get_tree().create_timer(PREVIEW_PLAYDELAY).timeout # Ensure the last thing we do is trigger a timer to stop the sound
		# Play preview of new sound
		%laughter_module/Laughter.Play()
		await get_tree().create_timer(PREVIEW_LENGTH).timeout # Ensure the last thing we do is trigger a timer to stop the sound
		%laughter_module/Laughter.Stop()

func _on_next_robot_pressed():
	UiSound.play_UI_NextRobot()
	if currentCustomerIndex == NUMBER_OF_ROBOTS_TO_MAKE_LAUGH:
		# Go to End Screen
		emit_signal("end_game")
		pass
	else:
		#invite new robot
		$panel_frame/panel_laugh_module.invite_robot()
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
		
		%laughter_module/Laughter.SetValue(globals.LaughParameter.Pitch,3)
		%laughter_module/Laughter.SetValue(globals.LaughParameter.Speed,3)
		%laughter_module/Laughter.SetValue(globals.LaughParameter.Volume,3)
		
		currentModelValues.SetPitch(%laughter_module/Laughter.pitch)
		currentModelValues.SetSpeed(%laughter_module/Laughter.speed)
		currentModelValues.SetVolume(%laughter_module/Laughter.volume)
		rest_color_current_value_colors()
		
func rest_color_current_value_colors():
		#rest Colors
		%Current_P_Value.label_settings.font_color = Color.WHITE
		%Current_S_Value.label_settings.font_color = Color.WHITE
		%Current_V_Value.label_settings.font_color = Color.WHITE
	
func _on_laugh_again_pressed():
	UiSound.play_UI_Click()
	laughterModule.Play()
	pass # Replace with function body.
func _on_button_launch_pressed():
	laughterModule.Play()
	calculate_result()
	pass # Replace with function body.

func calculate_result():
	currentCustomerIndex += 1
	var toatl_diff:int = 0
	var pitch_diff = abs(int(%label_pitch_value.text) - %laughter_module/Laughter.pitch)
	var speed_diff = abs(int(%label_speed_value.text) - %laughter_module/Laughter.speed)
	var vol_diff = abs(int(%label_volume_value.text) - %laughter_module/Laughter.volume)
	toatl_diff = pitch_diff + speed_diff + vol_diff
	
	var pitch_result = $panel_frame/ResultScreen/ModulePicture/HBoxContainer/ResultScreen_Pitch
	var speed_result = $panel_frame/ResultScreen/ModulePicture/HBoxContainer/ResultScreen_Speed
	var volume_result = $panel_frame/ResultScreen/ModulePicture/HBoxContainer/ResultScreen_Volume
	
	pitch_result.text = ("P." + %Current_P_Value.text)
	speed_result.text = ("S." + %Current_S_Value.text)
	volume_result.text = ("V." + %Current_V_Value.text)
	
	ChangeTextColor(pitch_result,pitch_diff)
	ChangeTextColor(speed_result,speed_diff)
	ChangeTextColor(volume_result,vol_diff)
	
	if currentCustomerIndex == NUMBER_OF_ROBOTS_TO_MAKE_LAUGH:
		$panel_frame/ResultScreen/Next_Robot.text = "Finished"
	if (toatl_diff<=3):
		#success
		$panel_frame/ResultScreen/Result_Title.text = "Great Job!"
		color_result_screen(globals.color_success)
		$panel_frame/ResultScreen/Text_Success.visible = 1
		globals.happy_customers += 1
	elif (toatl_diff <=5):
		#average
		$panel_frame/ResultScreen/Result_Title.text = "Good enough.."
		color_result_screen(globals.color_ok)
		$panel_frame/ResultScreen/Text_Average.visible = 1
	else:
		#fail
		$panel_frame/ResultScreen/Result_Title.text = "..whut..how..why?"
		color_result_screen(globals.color_fail)
		$panel_frame/ResultScreen/Text_Fail.visible = 1
	$panel_frame/ResultScreen.visible=1
	globals.total_score += toatl_diff
	pass

func _on_item_list_item_selected(index):
	print(%item_list.get_item_text(index))
	pass # Replace with function body.
	
func color_result_screen(color):
	$panel_frame/ResultScreen/Result_Title.label_settings.font_color = color

func colorCoat():
	var pitchDiff = abs(int(%label_pitch_value.text) - %laughter_module/Laughter.pitch)
	var speedDiff = abs(int(%label_speed_value.text) - %laughter_module/Laughter.speed)
	var volumeDiff = abs(int(%label_volume_value.text) - %laughter_module/Laughter.volume)
	ChangeTextColor(%Current_P_Value,pitchDiff)
	ChangeTextColor(%Current_S_Value,speedDiff)
	ChangeTextColor(%Current_V_Value,volumeDiff)
	
func ChangeTextColor(textNode, diffValue):
	if (diffValue<=1):
		textNode.label_settings.font_color = globals.color_success
	elif (diffValue <=3):
		textNode.label_settings.font_color = globals.color_ok
	else:
		textNode.label_settings.font_color = globals.color_fail


func _on_texture_rect_robot_button_pressed():
	if (robotClickCount >= 9):
		%texture_rect_robot_commentary.text = ""
		%texture_rect_robot_explosion.visible = true
		%texture_rect_robot_explosion.play()
		if(!$AudioStreamPlayer2D.playing):
			$AudioStreamPlayer2D.play()
		await get_tree().create_timer(1.0).timeout
		%texture_rect_robot_explosion.visible = false
		_on_next_robot_pressed()
	else: 
		%texture_rect_robot_commentary.text = robot_comments[randi_range(0, robot_comments.size() - 1)]
	robotClickCount = (robotClickCount + 1) % 10
	pass # Replace with function body.

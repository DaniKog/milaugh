extends ItemList

var item
@onready var description = $"../../../panel_object_description/text_description"
func _ready() -> void:
	pass

func _on_ItemList_gui_input(event: InputEvent) -> void:
	#doesn't trigger when assigned from Active Item list
	item = get_item_at_position(get_local_mouse_position(), true)
	if event is InputEventMouseMotion:
		if item != -1:
			description.text = get_item_tooltip(item)
			show_expected_result_on_current_module(item)
			
func show_expected_result_on_current_module(index):
	var property_to_hide = %item_list.get_item_metadata(index).property_to_hide
	
	var pitch_prediction_to_show = convert_int_to_result_string(%item_list.get_item_metadata(index).pitch)
	var speed_prediction_to_show = convert_int_to_result_string(%item_list.get_item_metadata(index).speed)
	var volume_prediction_to_show = convert_int_to_result_string(%item_list.get_item_metadata(index).volume)
	
	if(property_to_hide == Globals.LaughParameter.Pitch):
		pitch_prediction_to_show = "?"
	elif(property_to_hide == Globals.LaughParameter.Speed):
		speed_prediction_to_show = "?"
	elif(property_to_hide == Globals.LaughParameter.Volume):
		volume_prediction_to_show = "?"
	
	
	%Current_P_Addition.text = pitch_prediction_to_show
	%Current_S_Addition.text = speed_prediction_to_show
	%Current_V_Addition.text = volume_prediction_to_show
	
func hide_expected_result_on_current_module():
	%Current_P_Addition.text = ""
	%Current_S_Addition.text = ""
	%Current_V_Addition.text = ""
	
func convert_int_to_result_string(number):
	var text  = str(number)
	if number > 0:
		return str('+' + text)
	else:
		return text


func _on_mouse_exited():
	hide_expected_result_on_current_module()

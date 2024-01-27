extends ItemList

var item
@onready var description = $"../../../panel_object_description/text_description"
func _ready() -> void:
	pass

func _on_ItemList_gui_input(event: InputEvent) -> void:
	item = get_item_at_position(get_local_mouse_position(), true)
	if event is InputEventMouseMotion:
		if item != -1:
			description.text = (%item_list.get_item_tooltip(item))


func _on_gui_input(event):
	_on_ItemList_gui_input(event)

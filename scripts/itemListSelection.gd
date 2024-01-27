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

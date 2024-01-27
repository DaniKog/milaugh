extends Control

var modules = [
	load("res://resources/module-datas/evil-monkey.tres"),
	load("res://resources/module-datas/hot-sauce.tres")
]

# Called when the node enters the scene tree for the first time.
func _ready():
	for module in modules:
		%modifier_list.add_item(module.name, module.icon)
		
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_item_list_item_clicked(index, at_position, mouse_button_index):
	%laughter_module/Laughter.SetPitch(modules[index].pitch)
	%laughter_module/Laughter.SetSpeed(modules[index].speed)
	%laughter_module/Laughter.SetVolume(modules[index].volume)
	%laughter_module/Laughter.Play()
	
	# Add module to the list of active modifiers
	
	pass # Replace with function body.

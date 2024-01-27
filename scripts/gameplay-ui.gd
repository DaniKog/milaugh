extends Control

var modules = [
	load("res://resources/module-datas/top-hat.tres")
]

# Called when the node enters the scene tree for the first time.
func _ready():
	for module in modules:
		print(module)
		%modifier_list.add_item(module.name, module.icon)
		
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_item_list_item_clicked(index, at_position, mouse_button_index):
	print(index)
	
	# Add module to the list of active modifiers
	modules[index]
	$LaughterModule.play()
	
	pass # Replace with function body.

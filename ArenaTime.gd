extends PanelContainer

@export var arena_time_manager: Node
@onready var label: Label = $MarginContainer/Label
@onready var label2: Label = $MarginContainer/Label2

func _process(_delta):
	if arena_time_manager == null:
		return
	
	label.text = arena_time_manager.get_time_elapsed()
	label2.text = arena_time_manager.get_current_time()
	

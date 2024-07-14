extends PanelContainer

@export var arena_time_manager: Node
@onready var label = $MarginContainer/Label

func _process(delta):
	if arena_time_manager == null:
		return
	
	label.text = arena_time_manager.get_time_elapsed()
	

extends PanelContainer

@export var level_1_button: Button

func _ready():
	GameEvents.pause_game()
	
	level_1_button.pressed.connect(_start_level_1)


func _process(delta):
	pass


func _start_level_1():
	GameEvents.start_game()
	visible = false

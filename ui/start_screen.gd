extends PanelContainer

@export var button: Button

func _ready():
	button.pressed.connect(_button_pressed)


func _process(delta):
	if GameEvents.gameStatus == GAME_STATUS.SELECT_MODE:
		visible = true
	else:
		visible = false


func _button_pressed():
	GameEvents.start_game()

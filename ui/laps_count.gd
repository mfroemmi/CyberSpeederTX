extends PanelContainer

@onready var label = $MarginContainer/HBoxContainer/Label

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if GameEvents.gameStatus == GAME_STATUS.RACE_START || GameEvents.gameStatus == GAME_STATUS.RACE_RUNNING:
		visible = true
		label.text = GameEvents.roundCounter + " / 5"
	else:
		visible = false

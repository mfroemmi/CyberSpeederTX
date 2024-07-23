extends PanelContainer

@onready var labelCount = $MarginContainer/VBoxContainer/HBoxContainer/Label
@onready var labelStage = $MarginContainer/VBoxContainer/HBoxContainer2/Label

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if GameEvents.gameStatus == GAME_STATUS.RACE_START || GameEvents.gameStatus == GAME_STATUS.RACE_RUNNING:
		visible = true
		labelCount.text = GameEvents.roundCounter + " / 8"
		
		if GameEvents.stageCounter == "1":
			labelStage.text = "Unlock the path to stage two"
		if GameEvents.stageCounter == "2":
			labelStage.text = "Unlock the path to the final stage"
		if GameEvents.stageCounter == "3":
			labelStage.text = "Reach the finish line"
			
	else:
		visible = false

extends Node

var gameStatus = GAME_STATUS.SELECT_MODE
var stageStatus = STAGE_STATUS.NONE
var roundCounter = "0"
var stageCounter = "1"
var seconds_passed = 0
	

func _process(_delta):
	if Input.is_action_just_pressed("restart"):
		restart()
		

func start_game():
	gameStatus = GAME_STATUS.RACE_START
	
	
func is_race_running():
	if gameStatus == GAME_STATUS.RACE_RUNNING:
		return true
	else:
		return false


func increase_round():
	match roundCounter:
		"0":
			roundCounter = "1"
			#stageStatus = STAGE_STATUS.STAGE_ONE_COMPLETE
			return
		"1":
			roundCounter = "2"
			#stageStatus = STAGE_STATUS.STAGE_TWO_COMPLETE
			return
		"2":
			roundCounter = "3"
			return
		"3":
			roundCounter = "4"
			return
		"4":
			roundCounter = "5"
			stageCounter = "2"
			stageStatus = STAGE_STATUS.STAGE_ONE_COMPLETE
			return
		"5":
			roundCounter = "6"
			return
		"6":
			roundCounter = "7"
			return
		"7":
			roundCounter = "8"
			stageCounter = "3"
			stageStatus = STAGE_STATUS.STAGE_TWO_COMPLETE
			return
	

func reset():
	get_tree().change_scene_to_file("res://scenes/main.tscn")
	
func restart():
	get_tree().change_scene_to_file("res://scenes/main.tscn")
	gameStatus = GAME_STATUS.SELECT_MODE
	stageStatus = STAGE_STATUS.NONE
	roundCounter = "0"
	stageCounter = "1"
	seconds_passed = 0

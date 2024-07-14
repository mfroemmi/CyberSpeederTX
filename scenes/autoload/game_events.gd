extends Node

var gameStatus = GAME_STATUS.SELECT_MODE


func start_game():
	gameStatus = GAME_STATUS.RACE_START
	
	
func is_race_running():
	if gameStatus == GAME_STATUS.RACE_RUNNING:
		return true
	else:
		return false

extends Node

var isRunning = false

func start_game():
	isRunning = true
	
func pause_game():
	isRunning = false
	
func is_game_running():
	return isRunning

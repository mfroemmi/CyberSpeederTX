extends Node

@export var raceStartTimer: Timer
@export var miniGameRunningTimer: Timer


func _ready():
	raceStartTimer.timeout.connect(on_race_start_timer_timeout)
	miniGameRunningTimer.timeout.connect(on_mini_game_running_timer_timeout)

func _process(_delta):
	if GameEvents.gameStatus == GAME_STATUS.RACE_START && raceStartTimer.time_left == 0:
		raceStartTimer.start()
	if GameEvents.gameStatus == GAME_STATUS.MINI_GAME_RUNNING && miniGameRunningTimer.time_left == 0:
		miniGameRunningTimer.start()

func get_time_elapsed():
	if GameEvents.gameStatus == GAME_STATUS.RACE_START:
		return format_seconds_to_string(raceStartTimer.time_left)
	if GameEvents.gameStatus == GAME_STATUS.MINI_GAME_RUNNING:
		return format_seconds_to_string(miniGameRunningTimer.time_left)
	else:
		return ""

func format_seconds_to_string(seconds: float):
	var minutes = floor(seconds / 60)
	var remaining_seconds = seconds - (minutes * 60)
	return str(minutes) + ":" + ("%02d" % floor(remaining_seconds))
	

func on_race_start_timer_timeout():
	GameEvents.gameStatus = GAME_STATUS.RACE_RUNNING
	
func on_mini_game_running_timer_timeout():
	GameEvents.gameStatus = GAME_STATUS.RACE_RUNNING

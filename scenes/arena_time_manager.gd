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
	else:
		return ""

func get_current_time():
	if GameEvents.gameStatus == GAME_STATUS.RACE_RUNNING:
		GameEvents.seconds_passed += 1
		return format_current_seconds_to_string(GameEvents.seconds_passed)
	else:
		return ""

func format_seconds_to_string(seconds: float):
	var minutes = floor(seconds / 60)
	var remaining_seconds = seconds - (minutes * 60)
	return str(floor(remaining_seconds))
	
func format_current_seconds_to_string(time_in_seconds: int):
	var minutes = time_in_seconds / 60
	var seconds = time_in_seconds % 60
	return str(minutes) + ":" + str(seconds)

func on_race_start_timer_timeout():
	GameEvents.gameStatus = GAME_STATUS.RACE_RUNNING
	
func on_mini_game_running_timer_timeout():
	GameEvents.gameStatus = GAME_STATUS.RACE_RUNNING

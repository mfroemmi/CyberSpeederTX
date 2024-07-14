extends Node

@export var start_screen_scene: PackedScene
@export var raceStartTimer: Timer
@export var raceRunningTimer: Timer


func _ready():
	raceStartTimer.timeout.connect(on_race_start_timer_timeout)
	raceRunningTimer.timeout.connect(on_race_running_timer_timeout)

func _process(delta):
	if GameEvents.gameStatus == GAME_STATUS.RACE_START && raceStartTimer.time_left == 0:
		raceStartTimer.start()
	if GameEvents.gameStatus == GAME_STATUS.RACE_RUNNING && raceRunningTimer.time_left == 0:
		raceRunningTimer.start()

func get_time_elapsed():
	if GameEvents.gameStatus == GAME_STATUS.RACE_START:
		return format_seconds_to_string(raceStartTimer.time_left)
	if GameEvents.gameStatus == GAME_STATUS.RACE_RUNNING:
		return format_seconds_to_string(raceRunningTimer.time_left)
	else:
		return ""

func format_seconds_to_string(seconds: float):
	var minutes = floor(seconds / 60)
	var remaining_seconds = seconds - (minutes * 60)
	return str(minutes) + ":" + ("%02d" % floor(remaining_seconds))
	

func on_race_start_timer_timeout():
	GameEvents.gameStatus = GAME_STATUS.RACE_RUNNING
	
func on_race_running_timer_timeout():
	GameEvents.gameStatus = GAME_STATUS.SELECT_MODE

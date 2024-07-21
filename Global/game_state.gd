extends Node

const MAX_HP = 3
const MIN_LEVEL = 1
const MAX_LEVEL = 20
const INITIAL_DROP_INTERVAL = 0.8
const DROP_INTERVAL_STEP = 0.15
const MIN_DROP_INTERVAL = 0.2
const INITIAL_DROP_COUNT = 10
const MIN_DROP_SPEED = 150
const DROP_SPEED_STEP = 50
const MIN_DROPPER_SPEED = 200
const DROPPER_SPEED_STEP = 50
const ONE_UP_SCORE = 1000

var hp = MAX_HP
var level = MIN_LEVEL
var score = 0
var caught_bombs = 0
var level_started = false
var game_over = false

func reset() -> void:
	hp = MAX_HP
	level = MIN_LEVEL
	score = 0
	caught_bombs = 0
	level_started = false
	game_over = false
	set_score_label()
	update_catcher_size()
	reset_dropper()

func reset_dropper() -> void:
	get_node('/root/Game/Dropper').global_position.x = 640

func increase_score() -> void:
	update_score(level)
	
func update_score(delta: int) -> void:
	var old_score = score
	score += delta
	check_one_up(old_score)
	set_score_label()
	
func set_score_label() -> void:
	get_node("/root/Game/HUD/Score").text = str(score)
	
func check_one_up(old_score: int) -> void:
	if old_score % ONE_UP_SCORE > score % ONE_UP_SCORE:
		update_hp(1)
		get_node("/root/Game/OneUpSound").play()

func bomb_caught() -> void:
	increase_score()
	caught_bombs += 1
	
	if caught_bombs >= get_drop_count():
		level_started = false
		caught_bombs = 0
		update_level(1)

func bomb_dropped() -> void:
	update_level(-1)
	update_hp(-1)
	level_started = false
	caught_bombs = 0

func update_level(delta: int) -> void:
	level = min(
		max(level + delta, MIN_LEVEL), # ensure level is at least MIN_LEVEL 
		MAX_LEVEL # ensure level is at most MAX_LEVEL
	)

func update_hp(delta: int) -> void:
	hp = min(hp + delta, MAX_HP)
	game_over = hp <= 0
	update_catcher_size()
		
func update_catcher_size() -> void:
	get_node("/root/Game/Catcher").update_size(hp)

func get_drop_interval() -> float:
	return maxf(INITIAL_DROP_INTERVAL - (float(level - 1) * DROP_INTERVAL_STEP), MIN_DROP_INTERVAL)

func get_drop_count() -> int:
	return level * INITIAL_DROP_COUNT
	
func get_drop_speed() -> int:
	return MIN_DROP_SPEED + (DROP_SPEED_STEP * level)
	
func get_dropper_speed() -> int:
	return MIN_DROPPER_SPEED + (DROPPER_SPEED_STEP * level)

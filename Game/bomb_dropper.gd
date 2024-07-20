extends CharacterBody2D

const INITIAL_BOMB_COUNT = 10

var bomb_res := preload("res://Game/bomb.tscn")
@onready var drop_timer := $DropTimer
@onready var drop_point := $DropPoint
@onready var left_ray_cast := $LeftRayCast
@onready var right_ray_cast := $RightRayCast
@onready var change_direction_timer := $ChangeDirectionTimer

var bomb_pool := []
var drop_count := 0
var level_max_drops := 10
var move_speed := 200

func _ready() -> void:
	for i in range(0, INITIAL_BOMB_COUNT):
		var bomb = new_bomb()
		bomb_pool.append(bomb)
		add_child(bomb)

func _process(_delta):
	if left_ray_cast.is_colliding():
		change_direction(1)
	
	if right_ray_cast.is_colliding():
		change_direction(-1)

func _physics_process(delta) -> void:
	if is_on():
		move_and_collide(velocity * delta)

func new_bomb() -> CharacterBody2D:
	var bomb := bomb_res.instantiate()
	bomb.call_deferred("disable")
	
	return bomb
	
func get_bomb() -> CharacterBody2D:
	for b in bomb_pool:
		if not b.visible:
			return b
	
	return new_bomb()

func is_on() -> bool:
	return not drop_timer.is_stopped()

func start() -> void:
	if is_on():
		return
	
	drop_timer.wait_time = GameState.get_drop_interval()
	level_max_drops = GameState.get_drop_count()
	drop_count = 0
	drop_bomb()
	drop_timer.start()
	random_direction()
	change_direction_timer.start()

func stop() -> void:
	drop_timer.stop()
	change_direction_timer.stop()

func drop_bomb() -> void:
	var bomb = get_bomb()
	bomb.enable(
		drop_point.global_position,
		GameState.get_drop_speed()
	)

	drop_count += 1
	if drop_count >= level_max_drops:
		stop()
	
func reset_bomb(bomb: CharacterBody2D) -> void:
	bomb.disable()
	
func reset_all() -> void:
	for bomb in bomb_pool:
		reset_bomb(bomb)
		bomb.catch_effect.stop()
	
func change_direction(scalar: int) -> void:
	velocity.x = scalar * GameState.get_dropper_speed()

func random_direction() -> void:
	var rand = randf()
	var direction: int
	
	if rand < 0.4:
		direction = -1
	elif rand < 0.8:
		direction = 1
	else:
		direction = 0
	
	change_direction(direction)

func _on_drop_timer_timeout() -> void:
	drop_bomb()

func _on_change_direction_timer_timeout() -> void:
	random_direction()

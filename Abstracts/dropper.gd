extends CharacterBody2D

class_name Dropper

const INITIAL_DROPPABLE_COUNT = 10

var droppable_res
@onready var drop_timer := $DropTimer
@onready var drop_point := $DropPoint
@onready var left_ray_cast := $LeftRayCast
@onready var right_ray_cast := $RightRayCast
@onready var change_direction_timer := $ChangeDirectionTimer

var pool := []
var drop_count := 0
var level_max_drops := 10
var move_speed := 200

func _ready() -> void:
	for i in range(0, INITIAL_DROPPABLE_COUNT):
		var droppable = new_droppable()
		pool.append(droppable)
		add_child(droppable)

func _process(_delta) -> void:
	if left_ray_cast.is_colliding():
		change_direction(1)
		change_direction_timer.start()
	
	if right_ray_cast.is_colliding():
		change_direction(-1)
		change_direction_timer.start()	

func _physics_process(delta) -> void:
	if is_on():
		move_and_collide(velocity * delta)

func new_droppable() -> CharacterBody2D:
	var droppable = droppable_res.instantiate()
	droppable.call_deferred("disable")
	
	return droppable
	
func get_droppable() -> CharacterBody2D:
	for b in pool:
		if not b.visible:
			return b
	
	return new_droppable()

func is_on() -> bool:
	return not drop_timer.is_stopped()

func start() -> void:
	if is_on():
		return
	
	drop_timer.wait_time = GameState.get_drop_interval()
	level_max_drops = GameState.get_drop_count()
	drop_count = 0
	drop()
	drop_timer.start()
	random_direction()
	change_direction_timer.start()

func stop() -> void:
	drop_timer.stop()
	change_direction_timer.stop()

func drop() -> void:
	var droppable = get_droppable()
	droppable.enable(
		drop_point.global_position,
		GameState.get_drop_speed()
	)

	drop_count += 1
	if drop_count >= level_max_drops:
		stop()
	
func reset_droppable(droppable: CharacterBody2D) -> void:
	droppable.disable()
	
func reset_all() -> void:
	for droppable in pool:
		reset_droppable(droppable)
		droppable.catch_effect.stop()
	
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
	drop()

func _on_change_direction_timer_timeout() -> void:
	random_direction()

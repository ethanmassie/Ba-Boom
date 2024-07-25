extends CharacterBody2D

class_name Droppable

@onready var miss_effect := $MissEffect
@onready var catch_effect := $CatchEffect

func before_disable() -> void:
	pass
	
func after_disable() -> void:
	pass
	
func before_enable() -> void:
	pass
	
func after_enable() -> void:
	pass

func on_catch(_area: Area2D) -> void:
	pass

func _physics_process(delta) -> void:
	if visible:
		move_and_collide(velocity * delta)

func disable() -> void:
	before_disable()
	hide()
	global_position = Vector2(640, -1000)
	after_disable()
	
func enable(start_position: Vector2, speed: int) -> void:
	before_enable()
	self.position = start_position
	self.velocity.y = speed
	show()
	after_enable()

func _on_collider_area_entered(area: Area2D):
	if not visible:
		return
	if area.has_meta("IS_CATCHER") and area.visible:
		catch_effect.play()
		GameState.on_catch()
		on_catch(area)
		get_parent().reset_droppable(self)
	elif area.has_meta("IS_GROUND"):
		miss_effect.play()
		GameState.on_miss()
		get_parent().stop()
		get_parent().reset_all()

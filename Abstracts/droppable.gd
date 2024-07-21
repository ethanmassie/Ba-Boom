extends CharacterBody2D

class_name Droppable

@onready var animated_sprite := $AnimatedSprite
@onready var miss_effect := $MissEffect
@onready var catch_effect := $CatchEffect

func _physics_process(delta):
	if visible:
		move_and_collide(velocity * delta)

func disable() -> void:
	hide()
	global_position = Vector2(640, -1000)
	animated_sprite.stop()
	
func enable(start_position: Vector2, speed: int) -> void:
	animated_sprite.play()
	self.position = start_position
	self.velocity.y = speed
	show()

func _on_collider_area_entered(area: Area2D):
	if not visible:
		return
	if area.has_meta("IS_CATCHER") and area.visible:
		catch_effect.play()
		GameState.on_catch()
		get_parent().reset_droppable(self)
	elif area.has_meta("IS_GROUND"):
		miss_effect.play()
		GameState.on_miss()
		get_parent().stop()
		get_parent().reset_all()

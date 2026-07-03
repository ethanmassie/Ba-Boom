extends CharacterBody2D

@onready var drop_effect := $DropEffect
@onready var catch_effect := $CatchEffect
@onready var particles := $SparkParticles

func _physics_process(delta):
	if visible:
		move_and_collide(velocity * delta)

func disable() -> void:
	self.particles.emitting = false;
	hide()
	global_position = Vector2(640, -1000)
	
func enable(start_position: Vector2, speed: int) -> void:
	self.particles.emitting = true;
	self.position = start_position
	self.velocity.y = speed
	show()

func _on_collider_area_entered(area: Area2D):
	if not visible:
		return
	if area.has_meta("IS_BUCKET") and area.visible:
		area.splash()
		catch_effect.play()
		GameState.bomb_caught()
		get_parent().reset_bomb(self)
	elif area.has_meta("IS_GROUND"):
		drop_effect.play()
		GameState.bomb_dropped()
		get_parent().stop()
		get_parent().reset_all()

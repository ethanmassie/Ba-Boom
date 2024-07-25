extends Area2D

@onready var splash_particles := $SplashParticles
@onready var splash_stop_timer := $SplashStopTimer

func splash() -> void:
	splash_particles.emitting = true
	splash_stop_timer.start()


func _on_splash_stop_timer_timeout():
	splash_particles.emitting = false

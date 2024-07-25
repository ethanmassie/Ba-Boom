
extends Droppable

@onready var spark_particles := $SparkParticles

func before_disable() -> void:
	spark_particles.emitting = false
	
func before_enable() -> void:
	spark_particles.emitting = true

func on_catch(bucket) -> void:
	bucket.splash()

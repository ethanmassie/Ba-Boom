extends CharacterBody2D

const IS_BUCKET := true

@onready var top_bucket := $TopBucket
@onready var middle_bucket := $MiddleBucket
@onready var bottom_bucket := $BottomBucket

func _physics_process(_delta):
	position.x = get_viewport().get_mouse_position().x

func update_size(size):
	if size >= 3:
		enable_bucket(top_bucket)
		enable_bucket(middle_bucket)
		enable_bucket(bottom_bucket)
	elif size == 2:
		enable_bucket(top_bucket)
		enable_bucket(middle_bucket)
		disable_bucket(bottom_bucket)
	elif size == 1:
		enable_bucket(top_bucket)
		disable_bucket(middle_bucket)
		disable_bucket(bottom_bucket)
	else:
		disable_bucket(top_bucket)
		disable_bucket(middle_bucket)
		disable_bucket(bottom_bucket)
		
func enable_bucket(bucket: Area2D) -> void:
	bucket.show()
	
func disable_bucket(bucket: Area2D) -> void:
	bucket.hide()

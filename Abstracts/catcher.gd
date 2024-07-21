extends CharacterBody2D

class_name Catcher

func _physics_process(_delta):
	position.x = get_viewport().get_mouse_position().x

func update_size(size):
	pass

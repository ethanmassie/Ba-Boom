extends Node

func confine_mouse() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED_HIDDEN)
	
func release_mouse() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

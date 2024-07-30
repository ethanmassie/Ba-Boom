extends CharacterBody2D

class_name Catcher

var input_handler := follow_mouse

func _ready() -> void:
	set_input_handler()
	Config.change.connect(set_input_handler)

func _physics_process(_delta) -> void:
	input_handler.call()

func set_input_handler() -> void:
	match Config.get_control_mode():
		Config.PADDLE_MODE:
			input_handler = follow_paddle
		_:
			input_handler = follow_mouse

func follow_paddle() -> void:
	var joystick_vector = Input.get_vector("move_left", "move_right", "null", "null")
	position.x = joystick_vector.x * get_viewport().size.x
	
func follow_mouse() -> void:
	position.x = get_viewport().get_mouse_position().x

func update_size(_size):
	pass

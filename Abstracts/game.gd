extends Node2D

class_name Game

@onready var dropper := $Dropper
@onready var pause_menu := $PauseMenu

func _ready():
	confine_mouse()

func _process(_delta) -> void:
	if Input.is_action_just_pressed("start_level") and not GameState.level_started and not pause_menu.visible:
		start_level()
		
	if Input.is_action_just_pressed("pause") and not GameState.level_started:
		toggle_pause_menu()

func confine_mouse() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED_HIDDEN)
	
func release_mouse() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func start_level() -> void:
	if GameState.game_over:
		GameState.reset()
		
	GameState.level_started = true
	dropper.start()

func toggle_pause_menu() -> void:
	pause_menu.visible = !pause_menu.visible
	get_tree().paused = pause_menu.visible
	
	if pause_menu.visible:
		release_mouse()
	else:
		confine_mouse()

func _on_restart_button_pressed():
	GameState.reset()
	toggle_pause_menu()

func _on_full_screen_button_pressed():
	if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_WINDOWED:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

func _on_exit_button_pressed():
	toggle_pause_menu()

func _on_quit_button_pressed():
	get_tree().quit()

extends Node

const CONFIG_PATH = "user://settings.ini"
const MOUSE_MODE = 0
const PADDLE_MODE = 1

signal change

var config = ConfigFile.new()

func _ready():
	var err = config.load(CONFIG_PATH)
	if err != OK:
		print("Creating config file")
		create_default_config()
		
func create_default_config():
	set_selected_theme(ThemeManager.INITIAL_THEME)
	set_control_mode(MOUSE_MODE)
	save()

func get_selected_theme():
	return config.get_value("theme", "selected", 0)
	
func set_selected_theme(value: int):
	config.set_value("theme", "selected", value)
	change.emit()
	
func get_control_mode():
	var control_mode = config.get_value("control", "mode", MOUSE_MODE)
	if control_mode > PADDLE_MODE || control_mode < MOUSE_MODE:
		return MOUSE_MODE
		
	return control_mode
	
func set_control_mode(mode: int):
	config.set_value("control", "mode", mode)
	change.emit()
	
func save():
	config.save(CONFIG_PATH)

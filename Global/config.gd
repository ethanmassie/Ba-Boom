extends Node

const CONFIG_PATH = "user://settings.ini"

var config = ConfigFile.new()

func _ready():
	var err = config.load(CONFIG_PATH)
	if err != OK:
		print("Creating config file")
		create_default_config()
		
func create_default_config():
	set_selected_theme(ThemeManager.INITIAL_THEME)
	
	save()

func get_selected_theme():
	return config.get_value("theme", "selected", 0)
	
func set_selected_theme(value: int):
	config.set_value("theme", "selected", value)
	
func save():
	config.save(CONFIG_PATH)

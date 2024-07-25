extends Node

const INITIAL_THEME = 0
const BUILT_IN_THEMES: Array[Dictionary] = [
	{
		"text": "Retro",
		"scene": "res://Game/Themes/Retro/retro.tscn"
	}
]

var selected_theme := -1

func _ready() -> void:
	selected_theme = Config.get_selected_theme()
	if selected_theme >= len(get_themes()):
		printerr("Invalid theme id ", selected_theme)
		selected_theme = INITIAL_THEME
	
	call_deferred("set_theme", selected_theme)

func get_themes() -> Array[Dictionary]:
	return BUILT_IN_THEMES
	
func set_theme(id: int) -> void:
	if id == selected_theme:
		return
	var theme := BUILT_IN_THEMES[id]
	get_tree().change_scene_to_file(theme["scene"])
	
	Config.set_selected_theme(id)
	Config.save()

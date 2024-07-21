extends Node

const INITIAL_THEME = 0
const BUILT_IN_THEMES: Array[Dictionary] = [
	{
		"text": "Retro",
		"scene": "res://Game/Themes/Retro/retro.tscn"
	}
]

var selected_theme = INITIAL_THEME

func _ready() -> void:
	call_deferred("set_theme", selected_theme)

func get_themes() -> Array[Dictionary]:
	return BUILT_IN_THEMES
	
func set_theme(id: int) -> void:
	var theme := BUILT_IN_THEMES[id]
	get_tree().change_scene_to_file(theme["scene"])
	

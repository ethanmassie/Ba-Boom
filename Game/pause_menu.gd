extends CanvasLayer

@onready var theme_select = $VBoxContainer/ThemeSelect
@onready var control_select = $VBoxContainer/ControlSelect

func _ready() -> void:
	theme_select.selected = ThemeManager.selected_theme
	var themes = ThemeManager.get_themes()
	for i in len(themes):
		theme_select.add_item(themes[i]["text"], i)
		
	control_select.selected = Config.get_control_mode()

func toggle() -> void:
	visible = !visible
	get_tree().paused = visible
	
	if visible:
		Utils.release_mouse()
	else:
		Utils.confine_mouse()

func _on_restart_button_pressed():
	GameState.reset()
	toggle()

func _on_full_screen_button_pressed():
	if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_WINDOWED:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

func _on_theme_select_item_selected(index):
	ThemeManager.set_theme(index)

func _on_quit_button_pressed():
	get_tree().quit()

func _on_exit_button_pressed():
	toggle()

func _on_control_select_item_selected(index):
	Config.set_control_mode(index)
	Config.save()

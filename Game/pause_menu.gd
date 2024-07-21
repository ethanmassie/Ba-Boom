extends CanvasLayer

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

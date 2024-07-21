extends Node2D

class_name Game

@onready var dropper := $Dropper
@onready var pause_menu := $PauseMenu

func _ready():
	Utils.confine_mouse()

func _process(_delta) -> void:
	if Input.is_action_just_pressed("start_level") and not GameState.level_started and not pause_menu.visible:
		start_level()
		
	if Input.is_action_just_pressed("pause") and not GameState.level_started:
		pause_menu.toggle()

func start_level() -> void:
	if GameState.game_over:
		GameState.reset()
		
	GameState.level_started = true
	dropper.start()

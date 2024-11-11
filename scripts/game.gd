extends Node

var score : int = 0
var high_score : int = 0
var max_bleeds : int = 2000
var curr_bleeds : int = 0
var max_orbs : int = 5
var curr_orbs : int = 0
var fullscreen_mode : bool = false

func _ready() -> void:
	high_score = SaveSystem.get_var("high_score",high_score)
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

func _physics_process(_delta: float) -> void:
	if Input.is_action_just_released("fullscreen"):
		if !fullscreen_mode:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
			fullscreen_mode = true
		elif fullscreen_mode:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			fullscreen_mode = false

extends Control

@onready var highscorel: Label = $highscorel
@onready var retry: Button = $HBoxContainer/retry
@onready var quit: Button = $HBoxContainer/quit

func _ready() -> void:
	if Game.score > Game.high_score:
		Game.high_score = Game.score
	SaveSystem.set_var("high_score",Game.high_score)
	SaveSystem.save()
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	highscorel.text = str(SaveSystem.get_var("high_score"))
	if SaveSystem.get_var("high_score") == null:
		highscorel.text = " "
	retry.pressed.connect(retryf)
	quit.pressed.connect(quitf)

func retryf():
	get_tree().change_scene_to_file("res://scenes/world.tscn")

func quitf():
	get_tree().change_scene_to_file("res://scenes/mainmenu.tscn")

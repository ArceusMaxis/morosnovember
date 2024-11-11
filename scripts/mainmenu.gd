extends Control
@onready var play: Button = $HBoxContainer/play
@onready var quit: Button = $HBoxContainer/quit
@onready var highscorel: Label = $highscorel
@onready var itch: Button = $itch
@onready var fluoro: Button = $fluoro

func _ready() -> void:
	highscorel.text = str(SaveSystem.get_var("high_score"))
	if SaveSystem.get_var("high_score") == null:
		highscorel.text = " "
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	play.pressed.connect(playf)
	quit.pressed.connect(quitf)
	itch.pressed.connect(chaakweb)
	fluoro.pressed.connect(fluoroweb)

func chaakweb():
	OS.shell_open("https://chaak-007.itch.io")
	
func fluoroweb():
	OS.shell_open("https://unnamedcollective.itch.io/fluoroantimonic")

func playf():
	get_tree().change_scene_to_file("res://scenes/world.tscn")

func quitf():
	get_tree().quit()

func _physics_process(_delta: float) -> void:
	DisplayServer.window_set_title(rstr(8)+" :|: MOROS :|: "+rstr(8))

func rstr(length: int) -> String:
	var chars = "023456789"
	var result = ""
	for _i in range(length):
		result += chars[randi() % chars.length()]
	return result

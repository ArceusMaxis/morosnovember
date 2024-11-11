extends Node

const SAVE_FILE_PATH = "user://high_score.cfg"

func save_high_score():
	var config = ConfigFile.new()
	config.set_value("game", "high_score", Game.high_score)
	config.save(SAVE_FILE_PATH)

func load_high_score():
	var config = ConfigFile.new()
	var err = config.load(SAVE_FILE_PATH)
	if err == OK:
		Game.high_score = config.get_value("game", "high_score", 0)
	else:
		print("Failed to load high score. Error code: ", err)

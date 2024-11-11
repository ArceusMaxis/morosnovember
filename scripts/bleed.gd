extends Node3D

func _physics_process(_delta: float) -> void:
	global_position.y -= 0.05
	if global_position.y <= -5:
		Game.curr_bleeds -= 1
		queue_free()

func _on_player_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		get_tree().change_scene_to_file.call_deferred("res://scenes/gameover.tscn")

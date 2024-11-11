extends Node3D

@onready var timer: Timer = $Timer
@onready var pfx: CPUParticles3D = $pfx

func _ready() -> void:
	pfx.emitting = true
	timer.timeout.connect(bye)

func _on_collected(body: Node3D) -> void:
	if body.is_in_group("player"):
		body.blink()
		Game.curr_orbs -= 1
		Game.score += 1
		queue_free()

func bye() -> void:
	Game.curr_orbs -= 1
	queue_free()

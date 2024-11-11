extends Node3D

@onready var player: CharacterBody3D = %Player
@export var bleed_scn : PackedScene
@export var orb_scn : PackedScene
@export var lore : Array[String]
@onready var timer: Timer = %Timer

func pos(radius_min: float, radius_max: float) -> Vector2:
	var r2_max = radius_max * radius_max
	var r2_min = radius_min * radius_min
	var r = sqrt(randf() * (r2_max - r2_min) + r2_min)
	var t = randf() * TAU
	return Vector2(r * cos(t), r * sin(t))

func spawn_bleeds() -> void:
	if Game.curr_bleeds < Game.max_bleeds:
		var bleed = bleed_scn.instantiate()
		add_child(bleed)
		bleed.global_position = player.global_position + Vector3(pos(5,150).x,50,pos(5,150).y)
		Game.curr_bleeds += 1

func spawn_orbs() -> void:
	if Game.curr_orbs < Game.max_orbs:
		var orb = orb_scn.instantiate()
		add_child(orb)
		orb.global_position = player.global_position + Vector3(pos(20,70).x,0.5,pos(20,70).y)
		Game.curr_orbs += 1

func _ready() -> void:
	Game.score = 0
	Game.max_bleeds = 2000
	Game.curr_bleeds = 0
	Game.max_orbs = 5
	Game.curr_orbs = 0
	DisplayServer.window_set_title("MOROS :|: " + str(Game.score) +" :|: " + lore.pick_random())
	randomize()
	timer.timeout.connect(incre)

func _physics_process(_delta: float) -> void:
	spawn_bleeds()
	spawn_orbs()

func incre() -> void:
	Game.max_bleeds += 15
	if timer.wait_time > 0.5:
		timer.wait_time -= 0.1

func titlech() -> void:
	DisplayServer.window_set_title("MOROS :|: " + str(Game.score + 1) +" :|: " + lore.pick_random())

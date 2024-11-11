extends CharacterBody3D
@onready var camera: Camera3D = $Camera3D
@onready var ani: AnimationPlayer = $AnimationPlayer
@onready var scorel: Label = $hud/score
var speed : float = 5
var mouse_sensitivity : float = 0.001
const BOB_FREQ : float = 2.4
const BOB_AMP : float = 0.08
var t_bob : float = 0.0
@onready var collected: AudioStreamPlayer = $collected

func _ready() -> void:
	scorel.text = "0"
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _physics_process(delta):
	if Input.mouse_mode != Input.MOUSE_MODE_CAPTURED:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	scorel.text = str(Game.score)
	var input = Input.get_vector("left", "right", "forward", "back")
	var movement_dir = transform.basis * Vector3(input.x, 0, input.y)
	velocity.x = movement_dir.x * speed
	velocity.z = movement_dir.z * speed
	t_bob += delta * velocity.length() * float(is_on_floor())
	camera.transform.origin = _headbob(t_bob)
	move_and_slide()
	
	if Game.fullscreen_mode:
		scorel.add_theme_font_size_override("font_size", 60)
	else:
		scorel.add_theme_font_size_override("font_size", 30)
	
	if Input.is_action_just_pressed("quit"):
		get_tree().change_scene_to_file("res://scenes/mainmenu.tscn")

func _input(event):
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		rotate_y(-event.relative.x * mouse_sensitivity)
		$Camera3D.rotate_x(-event.relative.y * mouse_sensitivity)
		$Camera3D.rotation.x = clampf($Camera3D.rotation.x, -deg_to_rad(70), deg_to_rad(70))

func blink() -> void:
	ani.play("blink")
	collected.play()
	get_parent().titlech()

func _headbob(time) -> Vector3:
	var pos = Vector3.ZERO
	pos.y = 1.5 + sin(time * BOB_FREQ) * BOB_AMP
	pos.x = cos(time * BOB_FREQ / 2) * BOB_AMP
	return pos

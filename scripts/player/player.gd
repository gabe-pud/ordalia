extends CharacterBody3D

@export_group("camera")
@export_range(0.0,1.0) var mouse_sesitivity_x := 0.25
@export_range(0.0,1.0) var mouse_sesitivity_y := 0.08

@export_group("movement")
@export var base_move_speed := 7.0
@export var run_move_speed := 12.0
@export var acceleration := 40.0
@export var jump_velocity := 18.0
var move_speed := base_move_speed
var move_direction := Vector3.ZERO

@onready var camera_pivot: Node3D = %CameraStand
@onready var camera: Camera3D = %Camera3D
@onready var sprite: AnimatedSprite3D = %AnimatedSprite3D

var _camera_input_direction := Vector2.ZERO
@warning_ignore("unused_private_class_variable")
var _last_movement_direction := Vector3.BACK
var gravity = -ProjectSettings.get_setting("physics/3d/default_gravity")


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("left_click"):
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	if event.is_action_pressed("ui_cancel"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE


func _unhandled_input(event: InputEvent) -> void:
	var is_camera_motion := (
		event is InputEventMouseMotion and
		Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED
	)
	if is_camera_motion:
		_camera_input_direction = event.screen_relative


func _physics_process(delta: float) -> void:
	camera_pivot.rotation.x -= _camera_input_direction.y * mouse_sesitivity_y * delta
	camera_pivot.rotation.x = clamp(camera_pivot.rotation.x, -PI / 12.0, PI / 12.0)
	camera_pivot.rotation.y -= _camera_input_direction.x * mouse_sesitivity_x * delta
	
	_camera_input_direction = Vector2.ZERO


func get_movement_direction(delta) -> Vector3:
	var raw_input := Input.get_vector("left","right","foward","back")
	var foward = camera.global_basis.z
	var right = camera.global_basis.x

	var _move_direction = foward * raw_input.y + right * raw_input.x
	_move_direction.y = 0.0
	_move_direction = _move_direction.normalized()
	
	var y_velocity := velocity.y
	velocity.y = 0
	velocity = velocity.move_toward(_move_direction * move_speed, acceleration * delta)
	velocity.y = y_velocity + gravity * delta

	return _move_direction


func set_last_movement_direction(_move_direction):
	if _move_direction.length() > 0.2:
		_last_movement_direction = _move_direction
	var target_angle := Vector3.FORWARD.signed_angle_to(_last_movement_direction, Vector3.UP)
	sprite.global_rotation.y = target_angle

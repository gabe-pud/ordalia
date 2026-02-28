extends CharacterBody3D


@export_group("camera")
@export_range(0.0,1.0) var mouse_sesitivity_x := 0.25
@export_range(0.0,1.0) var mouse_sesitivity_y := 0.08
@export var lerp_power: float = 0.3

@onready var camera_pivot: Node3D = %CameraPivot
@onready var ots_camera: Camera3D = %OtsCamera
@onready var camera_stand: Node3D = %CameraStannd
@onready var locked_camera: Camera3D = %LockedCamera


@export_group("movement")
@export var base_move_speed := 7.0
@export var run_move_speed := 12.0
@export var acceleration := 40.0
@export var jump_velocity := 18.0
var move_speed := base_move_speed
var move_direction := Vector3.ZERO


@onready var sprite: AnimatedSprite3D = $AnimatedSprite3D
var _last_movement_direction := Vector3.BACK
var gravity = -ProjectSettings.get_setting("physics/3d/default_gravity")


func get_movement_direction(delta, speed_multiplyer = 1.0) -> Vector3:
	var raw_input := Input.get_vector("left","right","forward","back")
	
	var forward : Vector3
	var right : Vector3
	if ots_camera.current == true:
		forward = ots_camera.global_basis.z
		right = ots_camera.global_basis.x
	else:
		forward = locked_camera.global_basis.z
		right = locked_camera.global_basis.x

	var _move_direction = forward * raw_input.y + right * raw_input.x
	_move_direction.y = 0.0
	_move_direction = _move_direction.normalized()
	
	var y_velocity := velocity.y
	velocity.y = 0
	velocity = velocity.move_toward(_move_direction * move_speed * speed_multiplyer, acceleration * delta)
	velocity.y = y_velocity + gravity * delta

	return _move_direction


func set_last_movement_direction(_move_direction):
	if _move_direction.length() > 0.2:
		_last_movement_direction = _move_direction
	var target_angle := Vector3.FORWARD.signed_angle_to(_last_movement_direction, Vector3.UP)
	sprite.global_rotation.y = target_angle

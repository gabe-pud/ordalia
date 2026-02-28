extends Node3D

@export var Player: CharacterBody3D
@onready var camera_pivot: Node3D = %CameraPivot
@onready var ots_camera: Camera3D = %OtsCamera
var _camera_input_direction := Vector2.ZERO


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


func _process(delta: float) -> void:
	if ots_camera.current == true:
		camera_pivot.rotation.x -= _camera_input_direction.y * Player.mouse_sesitivity_y * delta
		camera_pivot.rotation.x = clamp(camera_pivot.rotation.x, -PI / 12.0, PI / 12.0)
		camera_pivot.rotation.y -= _camera_input_direction.x * Player.mouse_sesitivity_x * delta
		
		_camera_input_direction = Vector2.ZERO

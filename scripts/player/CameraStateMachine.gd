extends Node

@export var Player: CharacterBody3D
@export var movement_state_machine: Node
@export var animation_player: AnimationPlayer
var current_frame = 0

func _process(_delta):
	var move_state = movement_state_machine.current_state.name
	var angle_to_camera = camera_to_player_angle()
	
	if animation_player.current_animation:
		if current_frame >= animation_player.current_animation_length:
			current_frame = 0
		else:
			current_frame = animation_player.current_animation_position
	else:
		current_frame = 0
	
	match move_state:
		"PlayerIdle":
			animation_player.play("idle/idle_" + get_direction(angle_to_camera))
		"PlayerWalk":
			animation_player.play("walk/walk_" + get_direction(angle_to_camera))
		"PlayerRun":
			animation_player.play("run/run_" + get_direction(angle_to_camera))
		"PlayerJump":
			animation_player.play("jump/jump_" + get_direction(angle_to_camera))
		"PlayerFall":
			animation_player.play("fall/fall_" + get_direction(angle_to_camera))
	
	animation_player.seek(current_frame, true)


func camera_to_player_angle():
	return rad_to_deg(angle_difference(Player.sprite.global_rotation.y,Player.camera_pivot.global_rotation.y))


func get_direction(angle):
	if angle > 157.5:
		return "backwards"
	elif angle > 112.5:
		return  "diagonal_right_backwards"
	elif angle > 67.5:
		return  "right"
	elif angle > 22.5:
		return  "diagonal_right_fowards"
	elif angle > -22.5:
		return  "fowards"
	elif angle > -67.5:
		return  "diagonal_left_fowards"
	elif angle > -112.5:
		return  "left"
	elif angle > -157.5:
		return  "diagonal_left_backwards"
	else:
		return  "backwards"

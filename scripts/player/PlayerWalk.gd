extends State
class_name PlayerWalk

@export var Player: CharacterBody3D


func physics_update(delta):
	Player.move_speed = snapped(lerp(Player.move_speed, Player.base_move_speed, 2.5 * delta), 0.01)
	var move_direction = Player.get_movement_direction(delta)

	Player.move_and_slide()
	
	Player.set_last_movement_direction(move_direction)
	
	if move_direction.length() == 0:
		transition.emit("PlayerIdle")
	
	if Input.is_action_pressed("run"):
		transition.emit("PlayerRun")
	
	if Input.is_action_pressed("jump"):
		transition.emit("PlayerJump")

extends State
class_name PlayerRun

@export var Player: CharacterBody3D


func enter():
	Player.move_speed = Player.run_move_speed


func physics_update(delta):
	var move_direction = Player.get_movement_direction(delta)
	
	Player.move_and_slide()
	
	Player.set_last_movement_direction(move_direction)
	
	if move_direction.length() == 0:
		transition.emit("PlayerIdle")
	
	if !Input.is_action_pressed("run"):
		transition.emit("PlayerWalk")
		
	if Input.is_action_pressed("jump"):
		transition.emit("PlayerJump")

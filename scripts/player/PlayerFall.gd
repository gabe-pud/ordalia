extends State
class_name PlayerFall

@export var Player: CharacterBody3D
@export var HangColision: Area3D

func physics_update(delta):
	var move_direction = Player.get_movement_direction(delta)

	Player.move_and_slide()
	
	Player.set_last_movement_direction(move_direction)
	
	if HangColision.get_overlapping_areas().size() > 0:
		transition.emit("PlayerHang")
		
	if Player.velocity.y == 0:
		if Input.is_action_pressed("run") and move_direction.length() > 0:
			transition.emit("PlayerRun")
		elif move_direction.length() > 0:
			transition.emit("PlayerWalk")
		
		if move_direction.length() == 0:
			transition.emit("PlayerIdle")

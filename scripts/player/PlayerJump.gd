extends State
class_name PlayerJump 

@export var Player: CharacterBody3D


func physics_update(delta):
	var move_direction = Player.get_movement_direction(delta)
	
	if Player.is_on_floor():
		Player.velocity.y += Player.jump_velocity
	
	Player.move_and_slide()
	
	Player.set_last_movement_direction(move_direction)
	
	if Player.velocity.y < 0:
		transition.emit("PlayerFall")

extends State
class_name PlayerIdle 

@export var Player: CharacterBody3D


func enter():
	Player.move_speed = Player.base_move_speed

func physics_update(delta):
	var move_direction = Player.get_movement_direction(delta)
	
	Player.move_and_slide()
	
	if Input.is_action_pressed("run") and move_direction.length() > 0:
		transition.emit("PlayerRun")
	elif move_direction.length() > 0:
		transition.emit("PlayerWalk")
	
	if Input.is_action_pressed("jump") or player.velocity.y > 0:
		transition.emit("PlayerJump")
	
	if Player.velocity.y < 0:
		transition.emit("Playerfall")

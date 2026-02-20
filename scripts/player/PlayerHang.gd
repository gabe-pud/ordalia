extends State
class_name PlayerHang

@export var Player: CharacterBody3D
@export var HangColision: Area3D

var colision_position

func enter():
	var detected_area: Area3D = HangColision.get_overlapping_areas().front()
	colision_position = detected_area.position.y - 0.8

func exit():
	colision_position = null

func physics_update(delta):
	var move_direction = Player.get_movement_direction(delta, 0.2)
	
	if colision_position != null:
		Player.position.y = lerp(Player.position.y, colision_position, 0.2)

	Player.velocity.y = 0
	Player.move_and_slide()
	
	Player.set_last_movement_direction(move_direction)
	
	if Input.is_action_just_pressed("jump"):
		Player.velocity.y += Player.jump_velocity
		transition.emit("PlayerJump")
	
	if HangColision.get_overlapping_areas().size() == 0:
		transition.emit("PlayerFall")

extends Camera3D

@export var Player: CharacterBody3D
@onready var ots_camera_position: Node3D = %OtsCameraPosition


func _process(_delta: float) -> void:
	position = lerp(position, ots_camera_position.position, Player.lerp_power)

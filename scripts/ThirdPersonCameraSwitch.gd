extends Area3D


func _on_body_entered(body: Node3D) -> void:
	body.ots_camera.current = true
	body.locked_camera.current = false

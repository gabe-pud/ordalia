extends Area3D


func _on_body_entered(body: Node3D) -> void:
	body.locked_camera.current = true
	body.ots_camera.current = false

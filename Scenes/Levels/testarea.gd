extends StaticBody2D


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		print("1")
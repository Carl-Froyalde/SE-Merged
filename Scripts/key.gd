extends Area2D
var is_collected = false

func _on_body_entered(body: Node2D) -> void:
	if not is_collected:
		is_collected = true
		$AudioStreamPlayer2D.play()
		hide()

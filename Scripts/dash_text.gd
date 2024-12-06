extends Node2D

@onready var text = $"../../powerup"

func _on_powerup_body_entered(body: Node2D) -> void:
	text.disconnect("body_entered",_on_powerup_body_entered)
	$AnimationPlayer.play("show")
	await get_tree().create_timer(1).timeout
	text.queue_free()

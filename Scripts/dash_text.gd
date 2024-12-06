extends Node2D

@onready var dash = $"../../powerup"

func _on_dash_powerup_body_entered(body: Node2D) -> void:
	dash.disconnect("body_entered",_on_dash_powerup_body_entered)
	$AnimationPlayer.play("show")

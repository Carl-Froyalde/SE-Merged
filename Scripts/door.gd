extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


func _on_key_body_entered(body: Node2D) -> void:
	$AnimationPlayer2.play("move")

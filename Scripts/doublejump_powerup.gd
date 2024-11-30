extends Area2D

@onready var powUp = $Powerup
func _on_body_entered(body: Node2D) -> void:
	Global.unlockedDoubleJump = true
	powUp.play()
	hide()

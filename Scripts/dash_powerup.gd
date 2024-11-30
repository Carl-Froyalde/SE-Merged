extends Area2D
@onready var powUp = $Powerup
func _on_body_entered(body: Node2D) -> void:
	Global.unlockedDash = true
	powUp.play()
	hide()

extends Area2D
@onready var coinsfx = $Coin_Sound
var is_collected = false

func _on_body_entered(body: Node2D) -> void:
	if not is_collected:
		is_collected = true
		Global.score += 1
		coinsfx.play()
		hide()

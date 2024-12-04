extends Area2D

@onready var timer: Timer = $Timer
@onready var cam = $"../Player/Camera2D"
@onready var death = $death
@onready var player = $"../Player"

func _on_body_entered(body: Node2D) -> void:
	cam.applyShake()
	death.play()
	player.velocity.y = -400
	AudioControl._playFX("res://Assets/sounds/afterDeath.wav", -10.0)
	timer.start()

func _on_timer_timeout() -> void:
	
	player.die()

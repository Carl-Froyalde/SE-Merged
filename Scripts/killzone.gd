extends Area2D

@onready var timer: Timer = $Timer
@onready var cam = $"../Player/Camera2D"
@onready var death = $death

func _on_body_entered(body: Node2D) -> void:
	cam.applyShake()
	death.play()
	timer.start()

func _on_timer_timeout() -> void:
	Global.score = 0
	get_tree().reload_current_scene()

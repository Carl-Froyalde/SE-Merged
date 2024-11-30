extends Node2D

var key_collect = false
@onready var gate = $"../GateBody"
@onready var cam = $"../Player/Camera2D"
@onready var open = load("res://Assets/sounds/explosion.wav")
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		if key_collect == true:
			cam.applyShake()
			gate.queue_free()
		else:
			$AnimationPlayer.play("show")


func _on_body_exited(body: Node2D) -> void:
	$AnimationPlayer.play_backwards("show")


func _on_key_body_entered(body: Node2D) -> void:
	key_collect = true

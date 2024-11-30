extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimationPlayer.play("onStart")
	$AnimatedSprite2D.play("idle");


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_start_pressed() -> void:
	$buttonTap.play()
	await get_tree().create_timer(1.0).timeout
	AudioControl.play_levelselect()
	get_tree().change_scene_to_file("res://Scenes/GUI/Level Select.tscn")

func _on_settings_pressed() -> void:
	pass # Replace with function body.

func _on_exit_pressed() -> void:
	get_tree().quit()

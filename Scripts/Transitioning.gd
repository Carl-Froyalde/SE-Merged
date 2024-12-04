extends CanvasLayer

func change_scene(target: String) -> void:
	$AnimationPlayer.play("FadeTo")
	await get_tree().create_timer(0.8).timeout
	get_tree().change_scene_to_file(target)
	$AnimationPlayer.play_backwards("FadeTo")

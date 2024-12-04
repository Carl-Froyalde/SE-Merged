extends Area2D



func _on_area_entered(area: Area2D) -> void:
	Global.unlockedLevels += 1
	AudioControl._play("res://Assets/music/Victory sfx.mp3")
	get_tree().change_scene_to_file("res://Scenes/GUI/Victory.tscn")

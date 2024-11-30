extends Area2D



func _on_area_entered(area: Area2D) -> void:
	Global.unlockedLevels += 1
	AudioControl.play_levelselect()
	get_tree().change_scene_to_file("res://Scenes/GUI/Level Select.tscn")

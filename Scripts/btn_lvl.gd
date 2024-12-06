extends Button

@export_file var level_path
@export_file var music_path

func _on_pressed() -> void:
	if level_path == null:
		return
	if music_path != null:
		AudioControl._play(music_path, 5.0)
		Global.chestFound = 0
		Global.score = 0
		Global.currentHealth = Global.maxHealth
	TransitionScene.change_scene(level_path)

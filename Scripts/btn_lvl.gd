extends Button

@export_file var level_path
@export_file var music_path

var original_size := scale
var hover_size := Vector2(1.1, 1.1)

func _on_mouse_entered() -> void:
	btn_grow(hover_size,.1)

func _on_mouse_exited() -> void:
	btn_grow(original_size,.1)

func btn_grow(end_size: Vector2, duration: float) -> void:
	var tween := create_tween().set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self, 'scale', end_size, duration)

func _on_pressed() -> void:
	if level_path == null:
		return
	if music_path != null:
		AudioControl._play(music_path, 5.0)
		Global.chestFound = 0
		Global.score = 0
		Global.currentHealth = Global.maxHealth
	TransitionScene.change_scene(level_path)

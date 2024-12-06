extends Area2D

@export var victory_sfx: String = "res://Assets/music/Victory sfx.mp3"
@export var victory_scene: String = "res://Scenes/GUI/Victory.tscn"
@onready var level_root = $".."
func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player"):
		AudioControl._play(victory_sfx)
		level_root.level_complete()
		call_deferred("go_to_victory_scene")

func go_to_victory_scene() -> void:
	get_tree().change_scene_to_file(victory_scene)
	queue_free()

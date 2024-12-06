extends CanvasLayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	AudioControl._play("res://Assets/music/Forest Lullaby.wav")
	$AnimationPlayer.play("fadeIn")






func _on_animation_player_animation_finished(animation_name: String = "") -> void:
	AudioControl.play_levelselect()
	TransitionScene.change_scene("res://Scenes/GUI/Level Select.tscn")

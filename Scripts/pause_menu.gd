extends Control

func _on_pause_button_pressed() -> void:
	get_tree().paused = true
	$"AnimationPlayer".play("blur")

func _ready() -> void:
	$AnimationPlayer.play("RESET")

func resume():
	get_tree().paused = false
	$AnimationPlayer.play_backwards("blur")

func pause():
	get_tree().pause = true
	$AnimationPlayer.play("blur")

func _on_resume_pressed() -> void:
	resume()

func _on_restart_pressed() -> void:
	resume()
	get_tree().reload_current_scene()
 
func _on_quit_pressed() -> void:
	resume()
	AudioControl.stop()
	get_tree().change_scene_to_file("res://Scenes/GUI/MainMenu.tscn")

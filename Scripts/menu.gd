extends Control


var backstory_finished = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimationPlayer.play("onStart")
	$AnimatedSprite2D.play("idle");

func _on_start_pressed() -> void:
	$buttonTap.play()
	if backstory_finished == false:
		TransitionScene.change_scene("res://Scenes/GUI/backstory.tscn")
		backstory_finished = true
	else:
		AudioControl.play_levelselect()
		TransitionScene.change_scene("res://Scenes/GUI/Level Select.tscn")

func _on_exit_pressed() -> void:
	get_tree().quit()

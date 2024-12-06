extends Node2D


func level_complete() -> void:
	if Global.L2Complete == false:
		Global.L2Complete = true
		Global.unlockedLevels += 1
		print("Unlocked Level 3")
	else:
		pass

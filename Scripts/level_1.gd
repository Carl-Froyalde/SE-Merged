extends Node2D


func level_complete() -> void:
	if Global.L1Complete == false:
		Global.L1Complete = true
		Global.unlockedLevels += 1
		print("Unlocked Level 2")
	else:
		pass
	print(Global.unlockedLevels)

extends Node2D


func level_complete() -> void:
	if Global.L3Complete == false:
		Global.L3Complete = true
		Global.unlockedLevels += 1
	else:
		pass

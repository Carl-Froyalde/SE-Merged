extends Control

func _ready() -> void:
	for i in range($Levels.get_child_count()):
		Global.levels.append(+1)
	for level in $Levels.get_children():
		if str_to_var(level.name) in range(Global.unlockedLevels+1):
			level.disabled = false
			match level.name:
				2:
					Global.unlockedDash = true
				3:
					Global.unlockedDoubleJump = true
				4:
					Global.unlockedWallClimb = true
		else:
			level.disabled = true

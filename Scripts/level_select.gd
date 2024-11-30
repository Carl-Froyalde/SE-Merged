extends Control

func _ready() -> void:
	for i in range($Levels.get_child_count()):
		Global.levels.append(+1)
	print(Global.levels)
	for level in $Levels.get_children():
		if str_to_var(level.name) in range(Global.unlockedLevels+1):
			level.disabled = false
		else:
			level.disabled = true

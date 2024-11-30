extends Label

func _process(delta: float) -> void:
	self.text = "Chest Found: " + str(Global.chestFound)

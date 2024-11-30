extends Label


func _process(delta: float) -> void:
	self.text = "Y: " + str(Player.score)

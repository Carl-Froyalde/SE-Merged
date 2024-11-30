extends AnimatableBody2D
var opened = false
@onready var chest = $ChestBody
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite2D.play("idle")




func _on_chest_zone_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		print("I am entered")
		if opened == false:
			$AnimatedSprite2D.play("open")
			Global.chestFound += 1
			opened = true

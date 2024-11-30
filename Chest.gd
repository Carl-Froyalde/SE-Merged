extends Node2D

@export var interactable: bool = true
@onready var sprite = $AnimatedSprite2D  # Reference to the AnimatedSprite2D node

func _ready():
	# Connect the Area2D signal
	$Area2D.connect("body_entered", Callable(self, "_on_Area2D_body_entered"))

func _on_Area2D_body_entered(body):
	if interactable and body.is_in_group("Player"):
		open_chest()

func open_chest():
	sprite.play("open")
	interactable = false
	print("Chest opened!")

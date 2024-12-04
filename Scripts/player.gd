extends CharacterBody2D

@onready var jump_sfx = $jump_sfx
@onready var dash_sfx = $dash_sfx

const SPEED = 130.0
const JUMP_VELOCITY = -300.0
const DASH_SPEED = 400
const CLIMB_SPEED = -100.0  # Speed for climbing up the wall
var can_double_jump = false
var dashing = false
var can_dash = true
var is_climbing = false  # New variable for climbing state
var is_hanging = false
var start_pos : Vector2

var wallJumpCount = 0
var maxWallJump = 6

var MaxHealth = 3
var currentHealth = MaxHealth

var heart_list : Array[TextureRect] = []

func _ready() -> void:
	start_pos = global_position
	var heart_parent = $healthbar/healthcontainer
	for child in heart_parent.get_children():
		heart_list.append(child)


func _physics_process(delta: float) -> void:
	# Use global `can_double_jump` variable correctly
	var can_wall_climb = Global.unlockedWallClimb
	var can_dash = Global.unlockedDash

	if is_on_floor():
		$AnimatedSprite2D.play("idle")
		can_double_jump = true  # Reset double jump when on the floor
		wallJumpCount = 0      # Reset wall jump count when on the floor

	# Apply gravity only if not climbing or hanging
	if not (is_on_floor() or is_climbing or is_hanging):
		velocity += get_gravity() * delta

	# Wall climbing logic
	if is_on_wall() and Input.is_action_pressed("ui_up") and can_wall_climb:
		is_climbing = true
		velocity.y = CLIMB_SPEED  # Move the player upward
		$AnimatedSprite2D.play("climb")  # Play climbing animation
	else:
		is_climbing = false

	# Jumping
	if Input.is_action_just_pressed("Jump"):
		if is_on_floor():
			jump()
		elif can_double_jump and Global.unlockedDoubleJump:
			jump()
			can_double_jump = false  # Prevent further double jumps
		elif is_on_wall() and can_wall_climb:
			wall_jump()

	# Dashing
	if Input.is_action_just_pressed("Dash") and can_dash and Global.unlockedDash:
		start_dash()

	# Movement
	var direction = Input.get_axis("Move_left", "Move_right")
	if direction != 0:
		if dashing:
			velocity.x = direction * DASH_SPEED
		else:
			velocity.x = direction * SPEED
		$AnimatedSprite2D.flip_h = direction < 0  # Flip sprite based on direction
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	# Update animation only when standing still
	if velocity == Vector2.ZERO and !is_climbing:
		$AnimatedSprite2D.play("idle")

	move_and_slide()


func jump() -> void:
	$AnimatedSprite2D.play("jump")
	velocity.y = JUMP_VELOCITY
	jump_sfx.play()


func wall_jump() -> void:
	if wallJumpCount < maxWallJump:
		$AnimatedSprite2D.play("jump")
		velocity.y = JUMP_VELOCITY  # Jump away from the wall
		wallJumpCount += 1
		is_climbing = false  # Exit climbing state


func start_dash() -> void:
	dashing = true
	can_dash = false
	dash_sfx.play()
	$Dash_Timer.start()
	$Dash_Again_Timer.start()


func die() -> void:
	if currentHealth > 0:
		currentHealth -= 1
		update_health()
		global_position = start_pos
	else:
		Engine.time_scale = 0.05
		await get_tree().create_timer(0.1).timeout
		Engine.time_scale = 1.0
		AudioControl._play("res://Assets/sounds/Game Over Background.mp3")
		get_tree().change_scene_to_file("res://Scenes/GUI/Gameover.tscn")


func game_over() -> void:
	print("Gameover")
	# Implement screen transition logic here


func update_health() -> void:
	for i in range(heart_list.size()):
		heart_list[i].visible = i < currentHealth


# Stops dashing
func _on_dash_cooldown_timeout() -> void:
	dashing = false
	velocity.x = move_toward(velocity.x, 0, SPEED)


# Allows dashing again
func _on_dash_again_timer_timeout() -> void:
	can_dash = true


func _on_float_timer_timeout() -> void:
	is_hanging = false

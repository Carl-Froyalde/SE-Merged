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

func _physics_process(delta: float) -> void:
	$AnimatedSprite2D.play("idle")
	
	# Apply gravity only if not climbing
	if not is_on_floor() and not is_climbing:
		velocity += get_gravity() * delta
	
	# Wall climbing logic
	if is_on_wall() and Input.is_action_pressed("ui_up") and Global.unlockedWallClimb == true:
		is_climbing = true
		velocity.y = CLIMB_SPEED  # Move the player upward
		$AnimatedSprite2D.play("climb")  # Play climbing animation
	else:
		is_climbing = false

	# Jumping
	if Input.is_action_just_pressed("Jump"):
		$AnimatedSprite2D.play("jump")
		if is_on_floor():
			velocity.y = JUMP_VELOCITY
			can_double_jump = true  # Reset double jump
			jump_sfx.play()
		elif can_double_jump and Global.unlockedDoubleJump == true:
			$AnimatedSprite2D.play("jump")
			velocity.y = JUMP_VELOCITY
			can_double_jump = false
			jump_sfx.play()
		elif is_on_wall() and Global.unlockedWallClimb:  # Wall jump logic
			$AnimatedSprite2D.play("jump")
			velocity.y = JUMP_VELOCITY
			velocity.x = -Input.get_axis("Move_left", "Move_right") * SPEED  # Jump away from the wall
			is_climbing = false  # Exit climbing state

	# Dashing
	if Input.is_action_just_pressed("Dash") and can_dash and Global.unlockedDash == true:
		dashing = true
		can_dash = false
		dash_sfx.play()
		$Dash_Timer.start()
		$Dash_Again_Timer.start()

	# Movement
	var direction = Input.get_axis("Move_left", "Move_right")
	if direction:
		if dashing:
			velocity.x = direction * DASH_SPEED
		else:
			velocity.x = direction * SPEED
		$AnimatedSprite2D.flip_h = direction < 0  # Flip sprite based on direction
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

# Stops dashing
func _on_dash_cooldown_timeout() -> void:
	dashing = false

# Allows dashing again
func _on_dash_again_timer_timeout() -> void:
	can_dash = true

func _on_float_timer_timeout() -> void:
	is_hanging = false

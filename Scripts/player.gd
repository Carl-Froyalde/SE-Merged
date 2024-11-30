extends CharacterBody2D

@onready var jump_sfx = $jump_sfx
@onready var dashFX = $GPUParticles2D
const SPEED = 130.0
const JUMP_VELOCITY = -300.0
var can_double_jump = false  # Starts as false
const DASH_SPEED = 400
var dashing = false
var can_dash = true
var is_hanging = false

func _physics_process(delta: float) -> void:
	if is_on_floor():
		$AnimatedSprite2D.play("idle")
	
	# Apply gravity if not on the floor
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	# Play jump animations
	if not is_on_floor():
		if velocity.y < 0:
			$AnimatedSprite2D.play("jump")
		elif velocity.y > 0:
			$AnimatedSprite2D.play("jump")

	# Handle jump input
	if Input.is_action_just_pressed("jump"):
		$AnimatedSprite2D.play("jump")
		if is_on_floor():
			velocity.y = JUMP_VELOCITY
			can_double_jump = true  # Allow double jump when grounded
			jump_sfx.play()
		elif can_double_jump and Global.unlockedDoubleJump == true:
			velocity.y = JUMP_VELOCITY
			can_double_jump = false  # Disable double jump after using it
			jump_sfx.play()
	
	# Handle dash input
	if Input.is_action_just_pressed("Dash") and can_dash and Global.unlockedDash == true:
		dashing = true
		can_dash = false
		$Dash_Timer.start()
		dashFX.emitting = true
		$Dash_Again_Timer.start()
	
	# Handle movement
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
	dashFX.emitting = false
	dashing = false

# Allows dashing again
func _on_dash_again_timer_timeout() -> void:
	dashFX.emitting = false
	can_dash = true

func _on_float_timer_timeout() -> void:
	is_hanging = false

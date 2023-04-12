extends CharacterBody2D

@export_range(100.0, 500.0) var ACCELERATION := 280.0
@export_range(10.0, 100.0) var MAX_SPEED := 64.0
@export_range(1.0, 20.0) var FRICTION = 10.0
@export_range(0.0, 5.0) var AIR_RESISTANCE = 1.0
@export_range(0.0, 500.0) var JUMP_FORCE = 200
@export_range(100.0, 1000.0) var GRAVITY = 600.0

@onready var sprite = $Sprite2D
@onready var animationPlayer = $AnimationPlayer
@onready var emotion_anim = $EmotionAnimationPlayer

func _physics_process(delta):
	var x_input = Input.get_action_strength("right") - Input.get_action_strength("left")

	if x_input != 0.0:
		animationPlayer.play("Run")
		velocity.x += x_input * ACCELERATION * delta
		velocity.x = clamp(velocity.x, -MAX_SPEED, MAX_SPEED)
		sprite.flip_h = x_input < 0
	else:
		animationPlayer.play("Idle")

	if is_on_floor():
		if x_input == 0.0:
			velocity.x = lerp(velocity.x, 0.0, FRICTION * delta)
			
		if Input.is_action_just_pressed("up"):
			velocity.y = -JUMP_FORCE
	else:
		animationPlayer.play("Jump")
		if Input.is_action_just_released("up") and velocity.y < -JUMP_FORCE/2:
			velocity.y = -JUMP_FORCE * 0.5
		if x_input == 0.0:
			velocity.x = lerp(velocity.x, 0.0, AIR_RESISTANCE * delta)
		velocity.y += GRAVITY * delta
	
	velocity.y = min(velocity.y, 200.0)
	
	move_and_slide()
	
	if Input.is_action_just_pressed("1"):
		emotion_anim.stop()
		$Emotions.frame = randi() % 9
		emotion_anim.play("emotion_popup")

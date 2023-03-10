extends CharacterBody2D

const ACCELERATION = 280.0
const MAX_SPEED = 64.0
const FRICTION = 10.0
const AIR_RESISTANCE = 1.0
const JUMP_FORCE = 200
const GRAVITY = 600.0

@onready var sprite = $Sprite2D
@onready var animationPlayer = $AnimationPlayer
@onready var emotion_anim = $EmotionAnimationPlayer

var _prev_is_on_floor := true

#_physics_process may cause jitter and stutter
func _physics_process(delta):
	var x_input = Input.get_action_strength("right") - Input.get_action_strength("left")
	
	if x_input != 0.0:
		animationPlayer.play("Run")
		velocity.x += x_input * ACCELERATION * delta
		velocity.x = clamp(velocity.x, -MAX_SPEED, MAX_SPEED)
		sprite.flip_h = x_input < 0
	else:
		animationPlayer.play("Idle")
	
	velocity.y += GRAVITY * delta
	
	if is_on_floor() and !_prev_is_on_floor:
		pass
	_prev_is_on_floor = is_on_floor()
		
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
	
	velocity.y = min(velocity.y, 200.0)
	
	move_and_slide()
	
	if Input.is_action_just_pressed("1"):
		emotion_anim.stop()
		$Emotions.frame = randi() % 9
		emotion_anim.play("emotion_popup")

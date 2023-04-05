class_name PlayerA
extends CharacterBody2D

signal just_landed(fall_height)
signal is_hurt

@export_range(100.0, 500.0) var ACCELERATION := 280.0
@export_range(10.0, 100.0) var MAX_SPEED := 64.0
@export_range(1.0, 20.0) var FRICTION = 10.0
@export_range(0.0, 5.0) var AIR_RESISTANCE = 1.0
@export_range(0.0, 500.0) var JUMP_FORCE = 200
@export_range(100.0, 1000.0) var GRAVITY = 600.0

@export var sprite:AnimatedSprite2D
@export var anim:AnimationPlayer
@export var area:Area2D

var x_input:float
var jump_pressed:bool
var jump_released:bool
var duck_pressed:bool
var prev_is_on_floor:bool
var ground_recovery_counter:float
var play_hurt_animation:bool
var fall_start:float
var prev_velocity:Vector2

func _ready() -> void:
	Console.register_env("c",self)
	just_landed.connect(
		func(fall_distance:float):
			print("Fall Distance: ", fall_distance)
			if fall_distance > 32:
				ground_recovery_counter = 0.3
			play_hurt_animation = false
	)

func _physics_process(delta):
	prev_velocity = velocity
	move_and_slide()
	x_input = Input.get_action_strength("right") - Input.get_action_strength("left")
	duck_pressed = Input.is_action_pressed("down")
	jump_pressed = Input.is_action_just_pressed("up")
	jump_released = Input.is_action_just_released("up")

	if duck_pressed:
		x_input = 0.0

	if play_hurt_animation:
		x_input = 0.0
		jump_pressed = false
		jump_released = false
		duck_pressed = false

	if x_input != 0.0:
		velocity.x += x_input * ACCELERATION * delta
		velocity.x = clamp(velocity.x, -MAX_SPEED, MAX_SPEED)
		sprite.flip_h = x_input < 0

	if is_on_floor():
		if x_input == 0.0:
			velocity.x = lerp(velocity.x, 0.0, FRICTION * delta)
			
		if jump_pressed:
			velocity.y = -JUMP_FORCE
	else:
		if jump_released and velocity.y < -JUMP_FORCE/2:
			velocity.y = -JUMP_FORCE * 0.5
		if x_input == 0.0:
			velocity.x = lerp(velocity.x, 0.0, AIR_RESISTANCE * delta)
		velocity.y += GRAVITY * delta
	
	velocity.y = min(velocity.y, 200.0)
	if is_on_floor() and (!prev_is_on_floor):
		just_landed.emit(position.y - fall_start)
	if prev_velocity.y <= 0 and velocity.y > 0:
		fall_start = position.y

	update_animation()

	prev_is_on_floor = is_on_floor()
	ground_recovery_counter = move_toward(ground_recovery_counter, 0.0, delta)

func hurt():
	velocity = Vector2(get_face_direction() * -100.0, -160.0)
	play_hurt_animation = true
	anim.play("invinsible")
	var t = create_tween()
	t.tween_interval(1.5)
	t.tween_callback(
		func():
			anim.play("RESET")
	)
	is_hurt.emit()
	print("is_hurt")

func get_fall_height():
	if is_on_floor():
		return 0
	return position.y - fall_start

func get_face_direction():
	return -1 if sprite.flip_h else 1

func update_animation():
	var anim = ""
	if !is_on_floor():
		anim = "jumping"
		if get_fall_height() > 64 and velocity.y > 0:
			anim = "falling"
	else:
		if abs(velocity.x) <= 1.0:
			anim = "idle"
		else:
			anim = "running"
		if duck_pressed:
			anim = "ducking"
		if ground_recovery_counter > 0.0:
			anim = "ground_recovery"
	if play_hurt_animation:
		anim = "hurt"

	if sprite.animation != anim:
		sprite.play(anim)

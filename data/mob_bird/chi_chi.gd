extends CharacterBody2D

@export var max_speed := 40.0
@export var accel = 80.0

@onready var sprite := $AnimatedSprite2D
@export var follow_target:Node2D

func die():
	var effect = G.clound_poof_effect.instantiate()
	effect.position = position
	get_tree().root.add_child(effect)
	queue_free()

func _physics_process(delta):
	var target_velocity := Vector2()
	if follow_target:
		var d = position.distance_to(follow_target.global_position)
		var target_speed = max_speed * min(1, d / 16.0)
		target_velocity = (follow_target.global_position - position).normalized() * target_speed
	velocity = velocity.move_toward(target_velocity, accel * delta)
	move_and_slide()
	sprite.flip_h = velocity.x > 0

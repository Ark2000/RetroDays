extends CharacterBody2D

@export_category("dependency")
@export var sprite:AnimatedSprite2D
@export var hitbox:Area2D
@export_category("stats")
@export var jump_force := 200.0
@export var jump_interval := 2.0
@export var gravity_scale := 0.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")

var tween:Tween
var is_hurt := false

func _ready() -> void:
	tween = create_tween()
	tween.set_loops()
	tween.tween_callback(
		func():
			velocity.y += -jump_force
	).set_delay(jump_interval)

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta * gravity_scale
	if is_equal_approx(velocity.y, 0):
		sprite.play("idle")
	elif velocity.y > 0:
		sprite.play("fall")
	else:
		sprite.play("jump")
	if is_hurt:
		sprite.play("hurt")
	
	move_and_slide()

func die():
	get_node("CollisionShape2D").queue_free()
	hitbox.queue_free()
	velocity.y = 0.0
	is_hurt = true
	var t = create_tween()
	t.tween_callback(
		func():
			var effect = G.clound_poof_effect.instantiate()
			effect.position = sprite.global_position + Vector2(0, -6)
			get_tree().root.add_child(effect)
			queue_free()
	).set_delay(0.5)

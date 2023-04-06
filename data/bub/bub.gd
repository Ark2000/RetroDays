extends CharacterBody2D

@export var sprite:AnimatedSprite2D
@export var x_input := -1

const SPEED = 32.0
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta
	if is_on_wall():
		x_input *= -1
		sprite.flip_h = true if x_input > 0 else false
	velocity.x = x_input * SPEED
	move_and_slide()

func die():
	get_node("CollisionShape2D").queue_free()
	sprite.play("squished")
	var t = create_tween()
	t.tween_callback(queue_free).set_delay(0.5)

class_name MagicalOrbsSpell
extends AnimatedSprite2D

@export var life_time := 1.0
@export var max_velocity := Vector2(400.0, 0)

var velocity := Vector2()

func _ready() -> void:
	var t = create_tween()
	t.tween_interval(life_time)
	t.tween_callback(
		func():
			queue_free()
	)
	var t2 = create_tween()
	t2.tween_interval(life_time * 0.8)
	t2.tween_property(self, "modulate:a", 0.0, life_time * 0.2)

func _physics_process(delta: float) -> void:
	velocity = lerp(velocity, max_velocity, 0.1)
	position += velocity * delta

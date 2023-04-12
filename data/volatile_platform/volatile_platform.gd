extends StaticBody2D

@export var consume_rate := 1.0
@export var recover_rate := 0.5

@export var detector:Area2D
@export var sprite:AnimatedSprite2D

func _ready() -> void:
	detector.body_entered.connect(
		func(body):
			detector.get_node("CollisionShape2D").set_deferred("disabled", true)
			var t := create_tween()
			t.tween_interval(1.0 / consume_rate / 2)
			t.tween_callback(
				func():
					sprite.frame = 1
			)
			t.tween_interval(1.0 / consume_rate / 2)
			t.tween_callback(
				func():
					get_node("CollisionShape2D").set_deferred("disabled", true)
					var effect = G.clound_poof_effect.instantiate()
					effect.position = position
					get_tree().root.add_child(effect)
					sprite.frame = 2
			)
			t.tween_interval(1.0 / recover_rate)
			t.tween_callback(
				func():
					get_node("CollisionShape2D").set_deferred("disabled", false)
					detector.get_node("CollisionShape2D").set_deferred("disabled", false)
			)
			t.tween_interval(0.1)
			t.tween_callback(
				func(): sprite.frame = 1
			)
			t.tween_interval(0.1)
			t.tween_callback(
				func(): sprite.frame = 0
			)
	)


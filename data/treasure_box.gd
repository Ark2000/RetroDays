extends Area2D

@export var sprite:AnimatedSprite2D

const coin_img = preload("res://assets/items/common_pickups/CoinSingle.png")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	body_entered.connect(
		func(body):
			sprite.play("default")
			get_node("CollisionShape2D").set_deferred("disabled", true)
			play_animation()
	)

func play_animation():
	var t = create_tween()
	var s = 0.1
	for i in range(20):
		t.tween_callback(
			func():
				var item = Sprite2D.new()
				item.position = Vector2(0, -16)
				item.texture = coin_img
				item.scale = Vector2(0.6, 0.6)
				print(item)
				add_child(item)
				var t2 = create_tween()
				t2.tween_property(
					item, "position", Vector2(0, -32), s*4
				)
				t2.set_parallel(true)
				t2.tween_property(
					item, "modulate:a", 0.0, s*4
				)
				t2.set_parallel(false)
				t2.tween_callback(item.queue_free)
		)
		t.tween_interval(s)

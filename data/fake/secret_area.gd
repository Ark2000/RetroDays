extends Area2D

func _ready() -> void:
	modulate.a = 1.0
	body_entered.connect(
		func(_player):
			create_tween().tween_property(self, "modulate:a", 0.2, 0.5)
	)
	body_exited.connect(
		func(_player):
			create_tween().tween_property(self, "modulate:a", 1.0, 0.5)
	)

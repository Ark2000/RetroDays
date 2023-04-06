extends Area2D

@export var bounce := 150.0

func _ready() -> void:
	body_entered.connect(
		func(body):
			if body == get_parent(): return
			print("%s: %s entered" % [name, body.name])
			if get_parent().has_method("die"):
				get_parent().die()
			if body is CharacterBody2D:
				body.velocity.y = -bounce
			queue_free()
	)

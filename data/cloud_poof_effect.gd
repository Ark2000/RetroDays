extends Node2D

@export var sprite:AnimatedSprite2D

func _ready():
	sprite.animation_finished.connect(
		func():
			print("smoke queue free")
			queue_free()
	)

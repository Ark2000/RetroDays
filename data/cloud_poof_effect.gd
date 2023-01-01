extends Node2D

@onready var sprite := $AnimatedSprite2D

func _ready():
	sprite.animation_finished.connect(
		func():
			queue_free()
	)
	
	sprite.frame = 0
	sprite.play("default")

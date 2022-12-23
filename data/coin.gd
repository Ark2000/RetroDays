extends Area2D

func _ready():
	body_entered.connect(
		func(body:Node2D):
			queue_free()
	)

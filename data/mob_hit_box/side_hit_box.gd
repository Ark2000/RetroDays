extends Area2D

func _ready() -> void:
	body_entered.connect(
		func(area):
			print("%s: %s entered" % [name, area.name])
			if area.has_method("hurt"):
				area.hurt()
	)

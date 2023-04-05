extends Area2D


func _ready() -> void:
	area_entered.connect(
		func(area):
			if area.has_method("hurt"):
				area.hurt()
	)

extends Area2D

signal portal_entered

func _ready():
	body_entered.connect(
		func(_b):
			portal_entered.emit()
	)

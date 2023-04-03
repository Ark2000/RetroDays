extends Area2D

@export var respawn:Marker2D

func _ready():
	body_entered.connect(
		func(player:CharacterBody2D):
			player.position = respawn.position
			player.velocity = Vector2.ZERO
	)

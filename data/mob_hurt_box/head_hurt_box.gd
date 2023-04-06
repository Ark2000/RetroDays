extends Area2D

@export var bounce := 150.0

func _ready() -> void:
	body_entered.connect(_on_player_attack)
	area_entered.connect(_on_player_attack)

func _on_player_attack(body):
	if get_parent().has_method("die"):
		get_parent().die()
	if body is CharacterBody2D:
		body.velocity.y = -bounce
	if body is MagicalOrbsSpell:
		body.queue_free()

	queue_free()

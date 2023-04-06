class_name EmoBubble
extends Node2D

@export var sprite:Sprite2D
@export var anim:AnimationPlayer

func play_emo(idx:int):
	sprite.frame = idx
	if anim.is_playing():
		anim.stop()
	anim.play("pop")

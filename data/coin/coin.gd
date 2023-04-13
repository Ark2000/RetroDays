extends Area2D

func _ready():
	body_entered.connect(
		func(_body:Node2D):
			$AnimationPlayer.play("collected")
	)
	$AnimationPlayer.animation_finished.connect(
		func(_anim_name:String):
			queue_free()
	)

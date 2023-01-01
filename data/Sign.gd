extends Sprite2D

var t_modulate_a := 0.0
var triggered := false

func _ready():
	$MsgBox.modulate.a = t_modulate_a
	$Area2D.body_entered.connect(
		func(_b):
			t_modulate_a = 1.0
			set_process(true)
			if !triggered:
				$AnimationPlayer.play("die")
				triggered = true
	)
	$Area2D.body_exited.connect(
		func(_b):
			t_modulate_a = 0.0
			set_process(true)
	)

func _process(delta):
	var ta = $MsgBox.modulate.a
	$MsgBox.modulate.a = lerp($MsgBox.modulate.a, t_modulate_a, 0.21)
	$MsgBox.visible = !($MsgBox.modulate.a == 0.0)
	if abs(ta - $MsgBox.modulate.a) < 0.001:
		set_process(false)

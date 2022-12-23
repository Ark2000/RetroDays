extends Node2D

func _input(e:InputEvent):
	if e is InputEventKey and e.keycode == KEY_P and e.pressed:
		get_tree().change_scene_to_packed(G.game_over)

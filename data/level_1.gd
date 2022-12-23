extends Node2D

func _ready():
	$Portal.portal_entered.connect(
		func():
			G.intent["level_transition_next_scene"] = G.level_2
			G.intent["level_transition_text"] = "LEVEL 2"
			get_tree().change_scene_to_packed(G.level_transition)
	)

func _input(e:InputEvent):
	if e is InputEventKey and e.keycode == KEY_P and e.pressed:
		get_tree().change_scene_to_packed(G.game_over)

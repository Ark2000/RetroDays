extends Node2D

func _ready():
	$Portal.portal_entered.connect(
		func():
			G.intent["level_transition_next_scene"] = G.level_1
			G.intent["level_transition_text"] = "LEVEL 1"
			get_tree().change_scene_to_packed(G.level_transition)
	)

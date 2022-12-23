extends Control

func _ready():
	$Label.text = G.intent["level_transition_text"]
	await get_tree().create_timer(3.0).timeout
	get_tree().change_scene_to_packed(G.intent["level_transition_next_scene"])

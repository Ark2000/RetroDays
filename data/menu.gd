extends Control

@onready var btn1 := $Button
@onready var btn2 := $Button2

func _ready():
	btn1.pressed.connect(
		func():
			G.intent["level_transition_next_scene"] = G.level_1
			get_tree().change_scene_to_packed(G.level_transition)
	)
	btn2.pressed.connect(
		func():
			get_tree().quit()
	)

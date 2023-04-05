extends Node2D

@export var hearts_ui:HeartsUI
@export var player_a:PlayerA

var max_hp := 3
var hp := 3

func _ready() -> void:
	hearts_ui.set_max_hp(max_hp)
	hearts_ui.set_hp(hp)
	player_a.is_hurt.connect(
		func():
			hp -= 1
			hearts_ui.set_hp(hp)
	)

func _input(e:InputEvent):
	if e is InputEventKey and e.keycode == KEY_P and e.pressed:
		get_tree().change_scene_to_packed(G.game_over)

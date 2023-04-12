extends Node

const main_menu = preload("res://data/menu.tscn")
const level_1 = preload("res://data/level_1.tscn")
const level_2 = preload("res://data/level_2.tscn")
const level_transition = preload("res://data/level_transition.tscn")
const game_over = preload("res://data/game_over.tscn")

const clound_poof_effect = preload("res://data/cloud_poof_effect/cloud_poof_effect.tscn")

var intent = {}

func play_sfx(audio_stream:AudioStream, volumn_db := 0.0):
	var audio_player := AudioStreamPlayer.new()
	audio_player.volume_db = volumn_db
	audio_player.stream = audio_stream
	audio_player.autoplay = true
	audio_player.finished.connect(
		func():
			audio_player.queue_free()
	)
	add_child(audio_player)

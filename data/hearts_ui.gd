class_name HeartsUI
extends HBoxContainer

func set_max_hp(max_hp:int):
	for i in range(1, max_hp):
		add_child(get_node("EmptyHeart").duplicate())

func set_hp(hp:int):
	if hp < 0 or hp > get_child_count(): return
	for i in range(0, hp):
		get_child(i).get_child(0).show()
	for i in range(hp, get_child_count()):
		get_child(i).get_child(0).hide()

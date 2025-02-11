extends Node2D

func hide_sprites():
	for i in get_child_count():
		get_child(i).visible = false

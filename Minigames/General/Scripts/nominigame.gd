extends Node2D

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("a1"):
		$GameEnd.play("slide")

func end():
	var randnum = randi_range(1,8)
	match randnum:
		1:	
			Global.minigame_placements = [[1], [3], [4], [2]]
		2:	
			Global.minigame_placements = [[1], [4], [2], [3]]
		3:	
			Global.minigame_placements = [[2], [1], [3], [4]]
		4:	
			Global.minigame_placements = [[2], [4], [1], [3]]
		5:	
			Global.minigame_placements = [[3], [1], [2], [4]]
		6:	
			Global.minigame_placements = [[3], [2], [4], [1]]
		7:	
			Global.minigame_placements = [[4], [2], [3], [1]]
		8:	
			Global.minigame_placements = [[4], [3], [1], [2]]
	Global.switch_scene("res://Minigames/General/Scenes/minigame_results.tscn")

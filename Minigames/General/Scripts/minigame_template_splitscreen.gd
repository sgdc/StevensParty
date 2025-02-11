extends Node2D


#Track player scores here
var scores = [null, 0,0,0,0]

#Called automatically when the scene is loaded
func _ready() -> void:
	$AP.play("start")

#Call this function when you want to end the game. Placement will be calcualted
#for you based on the scores array.
func end_game():
	scores[0] = -1
	scores.erase(-1)
	var sorted_scores = scores.duplicate(true)
	sorted_scores.sort()
	sorted_scores.reverse()
	var a = 0
	while a <= 3:
		if scores[a] == sorted_scores[0]:
			Global.minigame_placements[0].append(a+1)
		a += 1
	if sorted_scores[1] != sorted_scores[0]:
		var b = 0
		while b <= 3:
			if scores[b] == sorted_scores[1]:
				Global.minigame_placements[1].append(b+1)
			b += 1
	if sorted_scores[2] != sorted_scores[1]:
		var c = 0
		while c <= 3:
			if scores[c] == sorted_scores[2]:
				Global.minigame_placements[2].append(c+1)
			c += 1
	if sorted_scores[3] != sorted_scores[2]:
		var d = 0
		while d <= 3:
			if scores[d] == sorted_scores[3]:
				Global.minigame_placements[3].append(d+1)
			d += 1
	$GameEnd.play("slide")

#Called automatically after end_game
func end():
	Global.switch_scene("res://Minigames/General/Scenes/minigame_results.tscn")

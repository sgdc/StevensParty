extends Node2D

#This can be removed or modified if player icons are not used
@onready var picon = [null, $"PlayerScores/1/Icon1", $"PlayerScores/2/Icon2",\
$"PlayerScores/3/Icon3", $"PlayerScores/4/Icon4"]

#Track player scores here
var scores = [null, 0,0,0,0]

#Called automatically when the scene is loaded
func _ready() -> void:
	set_icons()
	$AP.play("start")

#Called automatically from _ready. Remove if icons are not used.
func set_icons():
	var j = 1
	while j <= 4:
		match Global.playercharnum[j]:
			1: 
				picon[j].texture = load(Global.icon[1])
			2: 
				picon[j].texture = load(Global.icon[2])
			3: 
				picon[j].texture = load(Global.icon[3])
			4: 
				picon[j].texture = load(Global.icon[4])
			5: 
				picon[j].texture = load(Global.icon[5])
			6: 
				picon[j].texture = load(Global.icon[6])
			7: 
				picon[j].texture = load(Global.icon[7])
			8: 
				picon[j].texture = load(Global.icon[8])
			9: 
				picon[j].texture = load(Global.icon[9])
			10: 
				picon[j].texture = load(Global.icon[10])
		j += 1

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

#Click is called when a user presses the A button. Selected_item is the area
#body that the cursor was hovering over
func click(player_number, selected_item):
	if selected_item != null:
		pass

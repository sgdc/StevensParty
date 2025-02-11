extends Control

@onready var picon = [null, $Icons/Icon1,$Icons/Icon2,$Icons/Icon3,$Icons/Icon4]

var results_done = false

signal A

func _ready():
	set_colors()
	set_icons()
	set_placement_winnings()
	if Global.turn == Global.lastturn:
		final_results()
	else:
		set_stars_coins()
		await get_tree().create_timer(0.5).timeout
		$Icons.visible = true
		await get_tree().create_timer(0.5).timeout
		$Placement.visible = true
		await get_tree().create_timer(0.5).timeout
		$Winnings.visible = true
		await get_tree().create_timer(0.5).timeout
		$StarLabels.visible = true
		$CoinLabels.visible = true
		$Static.visible = true
		await get_tree().create_timer(0.5).timeout
		results_done = true
	
func final_results():
	set_final_stars_coins()
	await get_tree().create_timer(0.5).timeout
	$Icons.visible = true
	await get_tree().create_timer(0.5).timeout
	$Placement.visible = true
	await get_tree().create_timer(0.5).timeout
	$Winnings.visible = true
	await get_tree().create_timer(0.5).timeout
	await A
	$Icons/Icon1.visible = false
	$Icons/Icon2.visible = false
	$Icons/Icon3.visible = false
	$Icons/Icon4.visible = false
	$Placement/Place1.visible = false
	$Placement/Place2.visible = false
	$Placement/Place3.visible = false
	$Placement/Place4.visible = false
	$Winnings.visible = false
	var scores = [0, 0, 0, 0]
	var first = []
	var second = []
	var third = []
	var fourth = []
	scores[0] = Global.playerstar[1] * 1000 + Global.playercoin[1]
	scores[1] = Global.playerstar[2] * 1000 + Global.playercoin[2]
	scores[2] = Global.playerstar[3] * 1000 + Global.playercoin[3]
	scores[3] = Global.playerstar[4] * 1000 + Global.playercoin[4]
	var sorted_scores = scores.duplicate(true)
	sorted_scores.sort()
	sorted_scores.reverse()
	var a = 0
	while a <= 3:
		if scores[a] == sorted_scores[0]:
			first.append(a)
		a += 1
	if sorted_scores[1] != sorted_scores[0]:
		var b = 0
		while b <= 3:
			if scores[b] == sorted_scores[1]:
				second.append(b)
			b += 1
	if sorted_scores[2] != sorted_scores[1]:
		var c = 0
		while c <= 3:
			if scores[c] == sorted_scores[2]:
				third.append(c)
			c += 1
	if sorted_scores[3] != sorted_scores[2]:
		var d = 0
		while d <= 3:
			if scores[d] == sorted_scores[3]:
				fourth.append(d)
			d += 1
	await get_tree().create_timer(0.5).timeout
	if not fourth.is_empty():
		await flicker()
		for e in fourth:
			$Icons.get_child(e).visible = true
		await get_tree().create_timer(0.5).timeout
		for e in fourth:
			$Placement.get_child(e).text = "4th"
			$Placement.get_child(e).visible = true
		await get_tree().create_timer(0.5).timeout
		for e in fourth:
			$StarLabelsEnd.get_child(e).visible = true
			$CoinLabelsEnd.get_child(e).visible = true
			$StaticEnd.get_child(e).visible = true
			$StaticEnd.get_child(e+4).visible = true
		await A
	if not third.is_empty():
		await flicker()
		for e in third:
			$Icons.get_child(e).visible = true
		await get_tree().create_timer(0.5).timeout
		for e in third:
			$Placement.get_child(e).text = "3rd"
			$Placement.get_child(e).visible = true
		await get_tree().create_timer(0.5).timeout
		for e in third:
			$StarLabelsEnd.get_child(e).visible = true
			$CoinLabelsEnd.get_child(e).visible = true
			$StaticEnd.get_child(e).visible = true
			$StaticEnd.get_child(e+4).visible = true
		await A
	if not second.is_empty():
		await flicker()
		for e in second:
			$Icons.get_child(e).visible = true
		await get_tree().create_timer(0.5).timeout
		for e in second:
			$Placement.get_child(e).text = "2nd"
			$Placement.get_child(e).visible = true
		await get_tree().create_timer(0.5).timeout
		for e in second:
			$StarLabelsEnd.get_child(e).visible = true
			$CoinLabelsEnd.get_child(e).visible = true
			$StaticEnd.get_child(e).visible = true
			$StaticEnd.get_child(e+4).visible = true
		await A
	if not first.is_empty():
		if first.size() > 1:
			await flicker()
		for e in first:
			$Icons.get_child(e).visible = true
		await get_tree().create_timer(0.5).timeout
		for e in first:
			$Placement.get_child(e).text = "1st"
			$Placement.get_child(e).visible = true
		await get_tree().create_timer(0.5).timeout
		for e in first:
			$StarLabelsEnd.get_child(e).visible = true
			$CoinLabelsEnd.get_child(e).visible = true
			$StaticEnd.get_child(e).visible = true
			$StaticEnd.get_child(e+4).visible = true
	await get_tree().create_timer(1).timeout
	results_done = true
	
func flicker():
	var icons = []
	var count = -1
	if not $Icons/Icon1.visible:
		count += 1
		icons.append(0)
	if not $Icons/Icon2.visible:
		count += 1
		icons.append(1)
	if not $Icons/Icon3.visible:
		count += 1
		icons.append(2)
	if not $Icons/Icon4.visible:
		count += 1
		icons.append(3)
	var amount = 6
	if count == 3:
		amount = 8
	var new_count = 0
	while amount > 0:
		$Icons.get_child(icons[new_count]).visible = true
		await get_tree().create_timer(0.3).timeout
		$Icons.get_child(icons[new_count]).visible = false
		new_count += 1
		if new_count > count:
			new_count = 0
		amount -= 1
	for i in icons:
		$Icons.get_child(i).visible = false
	await get_tree().create_timer(0.6).timeout
	
func set_colors():
	$Panels/B.color = Global.blue
	$Panels/R.color = Global.red
	$Panels/G.color = Global.green
	$Panels/Y.color = Global.yellow
	
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

func set_placement_winnings():
	var i = 1
	while i <= 4:
		if Global.minigame_placements[0].has(i):
			$Placement.get_child(i-1).text = "1st"
			if Global.playerbonusextra[i] == 6:
				$Winnings.get_child(i-1).text = "+$10\nBonus\n+$10"
				Global.playerbonusextra[i] = 0
				Global.playercoin[i] += 20
			else:
				Global.playercoin[i] += 10
				$Winnings.get_child(i-1).text = "+$10"
		elif Global.minigame_placements[1].has(i):
			$Placement.get_child(i-1).text = "2nd"
			if Global.playerbonusextra[i] == 6:
				$Winnings.get_child(i-1).text = "+$3\nBonus\n+$5"
				Global.playerbonusextra[i] = 0
				Global.playercoin[i] += 8
			else:
				Global.playercoin[i] += 3
				$Winnings.get_child(i-1).text = "+$3"
		elif Global.minigame_placements[2].has(i):
			$Placement.get_child(i-1).text = "3rd"
			if Global.playerbonusextra[i] == 6:
				$Winnings.get_child(i-1).text = "+$2\nBonus\n+$3"
				Global.playerbonusextra[i] = 0
				Global.playercoin[i] += 5
			else:
				Global.playercoin[i] += 2
				$Winnings.get_child(i-1).text = "+$2"
		elif Global.minigame_placements[3].has(i):
			$Placement.get_child(i-1).text = "4th"
			if Global.playerbonusextra[i] == 6:
				$Winnings.get_child(i-1).text = "+$0\nBonus\n+$1"
				Global.playerbonusextra[i] = 0
				Global.playercoin[i] += 1
			else:
				$Winnings.get_child(i-1).text = "+$0"
		i += 1
	
func set_stars_coins():
	var k = 1
	while k <= 4:
		$StarLabels.get_child(k-1).text = str(Global.playerstar[k])
		$CoinLabels.get_child(k-1).text = "$" + str(Global.playercoin[k])
		k += 1
		
func set_final_stars_coins():
	var k = 1
	while k <= 4:
		$StarLabelsEnd.get_child(k-1).text = str(Global.playerstar[k])
		$CoinLabelsEnd.get_child(k-1).text = "$" + str(Global.playercoin[k])
		k += 1
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("a1") and results_done:
		$AP.play("fade_out")
	elif event.is_action_pressed("a1"):
		emit_signal("A")

func end():
	Global.minigame_placements = [[],[],[],[]]
	if Global.turn == Global.lastturn:
		Global.switch_scene("res://Title/title.tscn")
	else:
		Global.switch_scene("res://Board/Scenes/campus.tscn")

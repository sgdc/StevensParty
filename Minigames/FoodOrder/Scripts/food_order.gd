extends Node2D

@onready var picon = [null, $"PlayerScores/1/Icon1", $"PlayerScores/2/Icon2",\
$"PlayerScores/3/Icon3", $"PlayerScores/4/Icon4"]

var boxes = [null, "res://Minigames/FoodOrder/Assets/Boxes/bluebox.png",\
"res://Minigames/FoodOrder/Assets/Boxes/redbox.png",\
"res://Minigames/FoodOrder/Assets/Boxes/greenbox.png",\
"res://Minigames/FoodOrder/Assets/Boxes/yellowbox.png"]

var round_number = 1
var rounds = ["Red", "Spherical", "Yellow", "Meat", "Fruit", "Sweet"]
var item = ""
var pick = [null, "", "", "", ""]
var scores = [null, 0,0,0,0]
var order = []
var correct = []

func _ready() -> void:
	set_icons()
	$AP.play("start")
	
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

func new_round():
	$"PlayerScores/1/Score1".text = str(scores[1])
	$"PlayerScores/2/Score2".text = str(scores[2])
	$"PlayerScores/3/Score3".text = str(scores[3])
	$"PlayerScores/4/Score4".text = str(scores[4])
	item = ""
	pick = [null, "", "", "", ""] 
	order = []
	$PotLabel.visible = false
	$Timer.visible = false
	var random_number = randi_range(2, 4)
	await get_tree().create_timer(random_number).timeout
	var upper = rounds.size()-1
	random_number = randi_range(0, upper)
	item = rounds[random_number]
	$PotLabel.text = item
	$PotLabel.visible = true
	$Timer.text = "3"
	$Timer.visible = true
	$Countdown.start()

func _on_countdown_timeout() -> void:
	match $Timer.text:
		"1":
			$Timer.text = "0"
			end_round()
		"2":
			$Timer.text = "1"
			$Countdown.start()
		"3":
			$Timer.text = "2"
			$Countdown.start()

func end_round():
	$Splash.play()
	var i = 1
	match item:
		"Red":
			while i <= 4:
				match pick[i]:
					"Apple","Meat","Tomato","Ketchup","Bacon","Hotdog":
						pass
					_:
						if pick[i] != "":
							order.erase(i)
				i += 1
		"Spherical":
			while i <= 4:
				match pick[i]:
					"Apple","Cupcake","Burger","Cake","Tomato","Ketchup",\
					"Cookie","Icecream","Watermellon","Muffin","Lemon","Mustard":
						pass
					_:
						if pick[i] != "":
							order.erase(i)
				i += 1
		"Yellow":
			while i <= 4:
				match pick[i]:
					"Burger","Bananna","Icecream","Lemon","Hotdog","Mustard":
						pass
					_:
						if pick[i] != "":
							order.erase(i)
				i += 1
		"Meat":
			while i <= 4:
				match pick[i]:
					"Burger","Meat","Bacon","Hotdog":
						pass
					_:
						if pick[i] != "":
							order.erase(i)
				i += 1
		"Fruit": 
			while i <= 4:
				match pick[i]:
					"Apple","Bananna","Watermellon","Tomato","Lemon":
						pass
					_:
						if pick[i] != "":
							order.erase(i)
				i += 1
		"Sweet":
			while i <= 4:
				match pick[i]:
					"Cupcake","Cookie","Icecream","Watermellon","Cake","Ketchup":
						pass
					_:
						if pick[i] != "":
							order.erase(i)
				i += 1
	score()
	rounds.erase(item)
	item = ""
	await get_tree().create_timer(2.5).timeout
	for j in $Items.get_children():
		j.get_node("CollisionShape2D").get_node("Box").texture = null
	$"PlayerScores/1/Score1".text = str(scores[1])
	$"PlayerScores/2/Score2".text = str(scores[2])
	$"PlayerScores/3/Score3".text = str(scores[3])
	$"PlayerScores/4/Score4".text = str(scores[4])
	if rounds.size() == 1:
		await get_tree().create_timer(0.5).timeout
		end_game()
	else:
		new_round()
		
func score():
	var add_score = 5
	for i in order:
		$PlayerScores.get_child(i-1).get_child(1).text = "+" + str(add_score)
		scores[i] += add_score
		if add_score == 5:
			add_score = 3
		else:
			add_score -= 1
	var incorrect = []
	var j = 1
	while j <= 4:
		if not order.has(j):
			incorrect.append(j)
		j += 1
	for k in incorrect:
		$PlayerScores.get_child(k-1).get_child(1).text = "+0"

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

func end():
	Global.switch_scene("res://Minigames/General/Scenes/minigame_results.tscn")

func click(player_number, selected_item):
	if item != "" and selected_item != null and pick[player_number] == "":
		match selected_item.name:
			"Apple":
				if not pick.has("Apple"):
					pick[player_number] = "Apple"
					order.append(player_number)
					$Items/Apple/CollisionShape2D/Box.texture = \
					load(boxes[player_number])
			"Cupcake":
				if not pick.has("Cupcake"):
					pick[player_number] = "Cupcake"
					order.append(player_number)
					$Items/Cupcake/CollisionShape2D/Box.texture = \
					load(boxes[player_number])
			"Burger":
				if not pick.has("Burger"):
					pick[player_number] = "Burger"
					order.append(player_number)
					$Items/Burger/CollisionShape2D/Box.texture = \
					load(boxes[player_number])
			"Cookie":
				if not pick.has("Cookie"):
					pick[player_number] = "Cookie"
					order.append(player_number)
					$Items/Cookie/CollisionShape2D/Box.texture = \
					load(boxes[player_number])
			"Bananna":
				if not pick.has("Bananna"):
					pick[player_number] = "Bananna"
					order.append(player_number)
					$Items/Bananna/CollisionShape2D/Box.texture = \
					load(boxes[player_number])
			"Icecream":
				if not pick.has("Icecream"):
					pick[player_number] = "Icecream"
					order.append(player_number)
					$Items/Icecream/CollisionShape2D/Box.texture = \
					load(boxes[player_number])
			"Meat":
				if not pick.has("Meat"):
					pick[player_number] = "Meat"
					order.append(player_number)
					$Items/Meat/CollisionShape2D/Box.texture = \
					load(boxes[player_number])
			"Watermellon":
				if not pick.has("Watermellon"):
					pick[player_number] = "Watermellon"
					order.append(player_number)
					$Items/Watermellon/CollisionShape2D/Box.texture = \
					load(boxes[player_number])
			"Cake":
				if not pick.has("Cake"):
					pick[player_number] = "Cake"
					order.append(player_number)
					$Items/Cake/CollisionShape2D/Box.texture = \
					load(boxes[player_number])
			"Tomato":
				if not pick.has("Tomato"):
					pick[player_number] = "Tomato"
					order.append(player_number)
					$Items/Tomato/CollisionShape2D/Box.texture = \
					load(boxes[player_number])
			"Muffin":
				if not pick.has("Muffin"):
					pick[player_number] = "Muffin"
					order.append(player_number)
					$Items/Muffin/CollisionShape2D/Box.texture = \
					load(boxes[player_number])
			"Ketchup":
				if not pick.has("Ketchup"):
					pick[player_number] = "Ketchup"
					order.append(player_number)
					$Items/Ketchup/CollisionShape2D/Box.texture = \
					load(boxes[player_number])
			"Bacon":
				if not pick.has("Bacon"):
					pick[player_number] = "Bacon"
					order.append(player_number)
					$Items/Bacon/CollisionShape2D/Box.texture = \
					load(boxes[player_number])
			"Lemon":
				if not pick.has("Lemon"):
					pick[player_number] = "Lemon"
					order.append(player_number)
					$Items/Lemon/CollisionShape2D/Box.texture = \
					load(boxes[player_number])
			"Carrot":
				if not pick.has("Carrot"):
					pick[player_number] = "Carrot"
					order.append(player_number)
					$Items/Carrot/CollisionShape2D/Box.texture = \
					load(boxes[player_number])
			"Hotdog":
				if not pick.has("Hotdog"):
					pick[player_number] = "Hotdog"
					order.append(player_number)
					$Items/Hotdog/CollisionShape2D/Box.texture = \
					load(boxes[player_number])
			"Mustard":
				if not pick.has("Mustard"):
					pick[player_number] = "Mustard"
					order.append(player_number)
					$Items/Mustard/CollisionShape2D/Box.texture = \
					load(boxes[player_number])

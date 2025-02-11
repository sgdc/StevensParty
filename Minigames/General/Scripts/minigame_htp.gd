extends Control


@onready var picon = [null, $Icons/Icon1,$Icons/Icon2,$Icons/Icon3,$Icons/Icon4]

var readyup = [false, false, false, false]

@export var chosen_minigame = 0
var minigames = ["res://Minigames/FoodOrder/Scenes/food_order.tscn",\
"res://Minigames/NeighborhoodWatch/Scenes/neighborhoodwatch.tscn"] 
#add more here!

func _ready() -> void:
	set_icons()
	set_game()
	$AP.play("fade_in")

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

func set_game():
	#chosen_minigame = randi_range(0, minigames.size()-1)
	match chosen_minigame:
		0:
			#$GamePicture = load()
			$GameName.text = "Food Order"
			$Credits.text = "Matt Bernardon"
			$Origin.text = "SGDC Game Jam V"
			$Explain.text = "The pot will ask for a category of food. \
			Quickly select a food that satisfies the requirement. The \
			faster you are, the more points you'll score!"
			$Controls.text = "Left stick: Move Cursor\nA: Select food"
		1:
			#$GamePicture = load()
			$GameName.text = "Neighborhood Watch"
			$Credits.text = "Matt Bernardon"
			$Origin.text = "SGDC Game Jam W"
			$Explain.text = "Aliens are invading the neighborhood! Shoot to eliminate \
			them. Visit neighbors to collect more ammo. Last player standing is the winner!"
			$Controls.text = "Left stick: Move\nRight stick: Aim\nRB: Shoot"

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("a1") and not readyup[0]:
		readyup[0] = true
		$Ready/Ready1.visible = false
		if not readyup.has(false):
			start()
	elif event.is_action_pressed("a2") and not readyup[1]:
		readyup[1] = true
		$Ready/Ready2.visible = false
		if not readyup.has(false):
			start()
	elif event.is_action_pressed("a3") and not readyup[2]:
		readyup[2] = true
		$Ready/Ready3.visible = false
		if not readyup.has(false):
			start()
	elif event.is_action_pressed("a4") and not readyup[3]:
		readyup[3] = true
		$Ready/Ready4.visible = false
		if not readyup.has(false):
			start()
		
func start():
	await get_tree().create_timer(1).timeout
	$AP.play("fade_out")
	
func start_game():
	Global.switch_scene(minigames[chosen_minigame])

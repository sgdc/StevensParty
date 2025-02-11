extends Node2D


@onready var picon = [null,\
$Camera/CanvasLayer/prec1/picon1,$Camera/CanvasLayer/prec2/picon2,\
$Camera/CanvasLayer/prec3/picon3,$Camera/CanvasLayer/prec4/picon4]

@onready var player_sprite = [null, $Players/Player1, $Players/Player2,\
$Players/Player3, $Players/Player4]

@onready var camera = $Camera
@onready var laptop = $Camera/CanvasLayer/Laptop
@onready var number = $Camera/CanvasLayer/Number
@onready var bonus_number = $Camera/CanvasLayer/Bonus

@onready var coin_labels = [null, $Camera/CanvasLayer/prec1/coinslabel1,\
$Camera/CanvasLayer/prec2/coinslabel2,$Camera/CanvasLayer/prec3/coinslabel3,\
$Camera/CanvasLayer/prec4/coinslabel4]
@onready var star_labels = [null, $Camera/CanvasLayer/prec1/starlabel1,\
$Camera/CanvasLayer/prec2/starlabel2,$Camera/CanvasLayer/prec3/starlabel3,\
$Camera/CanvasLayer/prec4/starlabel4]
@onready var items = [null, [$Camera/CanvasLayer/prec1/Items1/I11,\
$Camera/CanvasLayer/prec1/Items1/I12,$Camera/CanvasLayer/prec1/Items1/I13],\
[$Camera/CanvasLayer/prec2/Items2/I21,$Camera/CanvasLayer/prec2/Items2/I22,\
$Camera/CanvasLayer/prec2/Items2/I23], [$Camera/CanvasLayer/prec3/Items3/I31,\
$Camera/CanvasLayer/prec3/Items3/I32, $Camera/CanvasLayer/prec3/Items3/I33],\
[$Camera/CanvasLayer/prec4/Items4/I41, $Camera/CanvasLayer/prec4/Items4/I42,\
$Camera/CanvasLayer/prec4/Items4/I43]]
@onready var borders = [null, $Camera/CanvasLayer/prec1/Border1,\
$Camera/CanvasLayer/prec2/Border2,$Camera/CanvasLayer/prec3/Border3,\
$Camera/CanvasLayer/prec4/Border4]
@onready var credits = $Credits

var starspace = "res://Board/Assets/starspace.png"
var bluespace = "res://Board/Assets/bluespace.png"

var intnum = 4 #number on the die

func _ready():
	set_colors()
	match_textures()
	update_scores()
	set_players()
	show_star()
	play_transitions()

func set_colors():
	$Camera/CanvasLayer/prec1.color = Global.blue + "c8"
	$Camera/CanvasLayer/prec2.color = Global.red + "c8"
	$Camera/CanvasLayer/prec3.color = Global.green + "c8"
	$Camera/CanvasLayer/prec4.color = Global.yellow + "c8"

func match_textures():
	var i = 1
	while i <= 4:
		player_sprite[i].get_child(0).visible = false
		i += 1
	var j = 1
	while j <= 4:
		match Global.playercharnum[j]:
			1: 
				picon[j].texture = load(Global.icon[1])
				player_sprite[j].get_child(0).visible = true
			2: 
				picon[j].texture = load(Global.icon[2])
				player_sprite[j].get_child(1).visible = true
			3: 
				picon[j].texture = load(Global.icon[3])
				player_sprite[j].get_child(2).visible = true
			4: 
				picon[j].texture = load(Global.icon[4])
				player_sprite[j].get_child(3).visible = true
			5: 
				picon[j].texture = load(Global.icon[5])
				player_sprite[j].get_child(4).visible = true
			6: 
				picon[j].texture = load(Global.icon[6])
				player_sprite[j].get_child(5).visible = true
			7: 
				picon[j].texture = load(Global.icon[7])
				player_sprite[j].get_child(6).visible = true
			8: 
				picon[j].texture = load(Global.icon[8])
				player_sprite[j].get_child(7).visible = true
			9: 
				picon[j].texture = load(Global.icon[9])
				player_sprite[j].get_child(8).visible = true
			10: 
				picon[j].texture = load(Global.icon[10])
				player_sprite[j].get_child(9).visible = true
		j += 1

func set_players():
	var i = 1
	while i <= 4:
		player_sprite[i].global_position = Global.playerpos[i]
		player_sprite[i].play("idle")
		player_sprite[i].flip(Global.playerflipped[i])
		i += 1

func play_transitions():
	camera.position = Vector2(2905, 1600)
	camera.zoom = Vector2(0.34, 0.34)
	Global.turn += 1
	$Camera/CanvasLayer/TurnLabel.text = "Turn\n" + str(Global.turn) + "/" +\
	str(Global.lastturn)
	$Camera/CanvasLayer/TurnLabelSmall.text=str(Global.turn)+"/"+str(Global.lastturn)
	$AP.play("fade_in")
	
func start_turn():
	if Global.starspot != 0:
		camera.reparent(player_sprite[Global.playerturn])
		camera.position = Vector2(0,0)
		camera.zoom = Vector2(0.8, 0.8)
		camera.reparent(self)
		borders[Global.playerturn].visible = true
		$Camera/CanvasLayer/TurnLabelSmall.visible = true
		player_sprite[Global.playerturn].check_items()
	else:
		var spot = randi_range(1,7)
		match spot:
			1:
				Global.starspot = 7
				$Spaces/S007.texture = load(starspace)
			2:
				Global.starspot = 29
				$Spaces/S029.texture = load(starspace)
			3:
				Global.starspot = 35
				$Spaces/S035.texture = load(starspace)
			4:
				Global.starspot = 44
				$Spaces/S044.texture = load(starspace)
			5:
				Global.starspot = 49
				$Spaces/S049.texture = load(starspace)
			6:
				Global.starspot = 61
				$Spaces/S061.texture = load(starspace)
			7:
				Global.starspot = 73
				$Spaces/S073.texture = load(starspace)
		spot = credits.get_node(str(Global.starspot))
		spot.visible = true
		var tween = create_tween()
		tween.tween_property(camera, "position", spot.global_position, 3)
		tween.parallel().tween_property(camera, "zoom", Vector2(0.9, 0.9), 3)
		await get_tree().create_timer(5.5).timeout
		start_turn()
			
func start_roll():
	if Global.playerbonusroll[Global.playerturn] > 0:
		bonus_number.text = "+" + str(Global.playerbonusroll[Global.playerturn])
	else:
		bonus_number.text = ""
	laptop.visible = true
	number.visible = true
	bonus_number.visible = true
	$Number_Timer.start()
	
func next_turn():
	borders[Global.playerturn].visible = false
	if Global.playerturn == Global.lastplayer:
		camera.reparent(self)
		camera.global_position = Vector2(2905, 1600)
		camera.zoom = Vector2(0.34, 0.34)
		var i = 1
		while i <= 4:
			Global.playerpos[i] = player_sprite[i].global_position
			Global.playerspaces[i] = player_sprite[i].current_space
			i += 1
		Global.playerturn = Global.firstplayer
		await get_tree().create_timer(2).timeout
		$AP.play("fade_out")
		await get_tree().create_timer(1.1).timeout
		pick_minigame()
	else:
		Global.playerturn += 1
		if Global.playerturn == 5:
			Global.playerturn = 1
		start_turn()

func update_scores():
	var i = 1
	while i <= 4:
		coin_labels[i].text = "$" + str(Global.playercoin[i])
		star_labels[i].text = str(Global.playerstar[i])
		var j = 0
		while j <= 2:
			var num = Global.playeritems[i][j] 
			if num > 0:
				items[i][j].hide_sprites()
				items[i][j].get_child(num-1).visible = true
			j += 1
		i += 1
		
func hide_item(i, j):
	items[i][j].hide_sprites()
	
func _on_number_timer_timeout() -> void:
	match intnum:
		1:
			intnum = 7
		2:
			intnum = 8
		3:
			intnum = 6
		4:
			intnum = 9
		5:
			intnum = 1
		6:
			intnum = 10
		7:
			intnum = 4
		8:
			intnum = 5
		9:
			intnum = 3
		10:
			intnum = 2
	number.text = str(intnum)

func pick_minigame():
	Global.switch_scene("res://Minigames/General/Scenes/nominigame.tscn")

func show_star():
	if Global.starspot == 0:
		return
	var spot = credits.get_node(str(Global.starspot))
	spot.visible = true
	match Global.starspot:
		7:
			$Spaces/S007.texture = load(starspace)
		17:
			$Spaces/S017.texture = load(starspace)
		29:
			$Spaces/S029.texture = load(starspace)
		35:
			$Spaces/S035.texture = load(starspace)
		44:
			$Spaces/S044.texture = load(starspace)
		49:
			$Spaces/S049.texture = load(starspace)
		61:
			$Spaces/S061.texture = load(starspace)
		73:
			$Spaces/S073.texture = load(starspace)

func new_star(old_space):
	var picked = false
	var spot = 0
	while not picked:
		picked = true
		spot = randi_range(1,8)
		match spot:
			1:
				if old_space == 7 or player_sprite[1].current_space == 7 or\
				player_sprite[2].current_space == 7 or player_sprite[3].\
				current_space == 7 or player_sprite[4].current_space == 7:
					picked = false
				else:
					Global.starspot = 7
					$Spaces/S007.texture = load(starspace)
			2:
				if old_space == 29 or player_sprite[1].current_space == 29 or\
				player_sprite[2].current_space == 29 or player_sprite[3].\
				current_space == 29 or player_sprite[4].current_space == 29:
					picked = false
				else:
					Global.starspot = 29
					$Spaces/S029.texture = load(starspace)
			3:
				if old_space == 35 or player_sprite[1].current_space == 35 or\
				player_sprite[2].current_space == 35 or player_sprite[3].\
				current_space == 35 or player_sprite[4].current_space == 35:
					picked = false
				else:
					Global.starspot = 35
					$Spaces/S035.texture = load(starspace)
			4:
				if old_space == 44 or player_sprite[1].current_space == 44 or\
				player_sprite[2].current_space == 44 or player_sprite[3].\
				current_space == 44 or player_sprite[4].current_space == 44:
					picked = false
				else:
					Global.starspot = 44
					$Spaces/S044.texture = load(starspace)
			5:
				if old_space == 49 or player_sprite[1].current_space == 49 or\
				player_sprite[2].current_space == 49 or player_sprite[3].\
				current_space == 49 or player_sprite[4].current_space == 49:
					picked = false
				else:
					Global.starspot = 49
					$Spaces/S049.texture = load(starspace)
			6:
				if old_space == 61 or player_sprite[1].current_space == 61 or\
				player_sprite[2].current_space == 61 or player_sprite[3].\
				current_space == 61 or player_sprite[4].current_space == 61:
					picked = false
				else:
					Global.starspot = 61
					$Spaces/S061.texture = load(starspace)
			7:
				if old_space == 73 or player_sprite[1].current_space == 73 or\
				player_sprite[2].current_space == 73 or player_sprite[3].\
				current_space == 73 or player_sprite[4].current_space == 73:
					picked = false
				else:
					Global.starspot = 73
					$Spaces/S073.texture = load(starspace)
			8:
				if old_space == 17 or player_sprite[1].current_space == 17 or\
				player_sprite[2].current_space == 17 or player_sprite[3].\
				current_space == 17 or player_sprite[4].current_space == 17:
					picked = false
				else:
					Global.starspot = 17
					$Spaces/S017.texture = load(starspace)
	var old_space_string = ""
	if old_space == 7:
		old_space_string = "S007"
	else:
		old_space_string = "S0" + str(old_space)
	$Spaces.get_node(old_space_string).texture =\
	load(bluespace)
	spot = credits.get_node(str(old_space))
	spot.visible = false
	spot = credits.get_node(str(Global.starspot))
	spot.visible = true
	camera.reparent(self)
	camera.position = Vector2(2905, 1600)
	camera.zoom = Vector2(0.34, 0.34)
	await get_tree().create_timer(1).timeout
	var tween = create_tween()
	tween.tween_property(camera, "position", spot.global_position, 3)
	tween.parallel().tween_property(camera, "zoom", Vector2(0.9, 0.9), 3)
	await get_tree().create_timer(5.5).timeout
	camera.reparent(player_sprite[Global.playerturn])
	camera.position = Vector2(0, 0)
	camera.zoom = Vector2(0.8, 0.8)

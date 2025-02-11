extends Node2D

var current_space = 13
var space_string = ""
var character = "Penguin"
var player_number = 1
var a = ""
var b = ""
var x = ""
var y = ""
var left = ""
var right = ""
var up = ""
var down = ""
var can_roll = false
var sum = 0
var recent_button = ""
var using_item = 0
var pizza = 8
var taco = 2

@onready var textbox_s = $"../../Camera/CanvasLayer/Textbox_small"
@onready var textbox_label_s = \
$"../../Camera/CanvasLayer/Textbox_small/Textbox_small_label"
@onready var textbox_l = $"../../Camera/CanvasLayer/Textbox_large"
@onready var textbox_label_l = \
$"../../Camera/CanvasLayer/Textbox_large/Textbox_large_label"
@onready var a_label = $"../../Camera/CanvasLayer/Textbox_large/A/A_Label"
@onready var x_label = $"../../Camera/CanvasLayer/Textbox_large/X/X_Label"
@onready var y_label = $"../../Camera/CanvasLayer/Textbox_large/Y/Y_Label"
@onready var b_label = $"../../Camera/CanvasLayer/Textbox_large/B/B_Label"
@onready var textbox_a = $"../../Camera/CanvasLayer/Textbox_admin"

@onready var PXY = $"../../PathXYs"

@onready var coin_label = $"../../Camera/CanvasLayer/Plus_Coin_Label"

@onready var laptop = $"../../Camera/CanvasLayer/Laptop"
@onready var die_number = $"../../Camera/CanvasLayer/Number"
@onready var bonus_number = $"../../Camera/CanvasLayer/Bonus"

@onready var camera = $"../../Camera"

@onready var textbox_item = $"../../Camera/CanvasLayer/Textbox_item"
@onready var item_A = $"../../Camera/CanvasLayer/Textbox_item/A"
@onready var item_X = $"../../Camera/CanvasLayer/Textbox_item/X"
@onready var item_Y = $"../../Camera/CanvasLayer/Textbox_item/Y"

@onready var textbox_shop = $"../../Camera/CanvasLayer/Textbox_shop"
@onready var shop_A = $"../../Camera/CanvasLayer/Textbox_shop/A"
@onready var shop_X = $"../../Camera/CanvasLayer/Textbox_shop/X"
@onready var shop_Y = $"../../Camera/CanvasLayer/Textbox_shop/Y"

signal AandB
signal XandY
signal ABXY

func _ready():
	if name.contains("1"):
		character = Global.playerchar[1] 
		player_number = 1
		current_space = Global.playerspaces[1]
		a = "a1"
		b = "b1"
		x = "x1"
		y = "y1"
		left = "left1"
		right = "right1"
		up = "up1"
		down = "down1"
	elif name.contains("2"):
		character = Global.playerchar[2] 
		player_number = 2
		current_space = Global.playerspaces[2]
		a = "a2"
		b = "b2"
		x = "x2"
		y = "y2"
		left = "left2"
		right = "right2"
		up = "up2"
		down = "down2"
	elif name.contains("3"):
		character = Global.playerchar[3] 
		player_number = 3
		current_space = Global.playerspaces[3]
		a = "a3"
		b = "b3"
		x = "x3"
		y = "y3"
		left = "left3"
		right = "right3"
		up = "up3"
		down = "down3"
	elif name.contains("4"):
		character = Global.playerchar[4]
		player_number = 4
		current_space = Global.playerspaces[4]
		a = "a4"
		b = "b4"
		x = "x4"
		y = "y4"
		left = "left4"
		right = "right4"
		up = "up4"
		down = "down4"

func play(ani):
	for i in get_child_count():
		if get_child(i).visible:
			get_child(i).play(ani)

func flip(boo):
	get_node(character).flip_h = boo

func _input(event: InputEvent) -> void:
	if event.is_action_pressed(a):
		recent_button = "A"
		emit_signal("AandB")
		emit_signal("ABXY")
		if can_roll:
			can_roll = false
			if using_item == 5 or using_item == 6 or using_item == 8:
				item_roll()
			else:
				roll()
			
	elif event.is_action_pressed(b):
		recent_button = "B"
		emit_signal("AandB")
		emit_signal("ABXY")
	elif event.is_action_pressed(x):
		recent_button = "X"
		emit_signal("XandY")
		emit_signal("ABXY")
	elif event.is_action_pressed(y):
		recent_button = "Y"
		emit_signal("XandY")
		emit_signal("ABXY")
		
func move_spaces(spaces_to_move):
	if spaces_to_move <= 0:
		die_number.visible = false
		get_node(character).play("idle")
		land_on_current_space()
	else:
		get_node(character).play("run")
		####################
		match current_space:
			10:
				PXY.get_node("X11").visible = true
				PXY.get_node("Y11").visible = true
				camera.can_move(true, player_number)
				await XandY
				camera.can_move(false, player_number)
				camera.position = Vector2(0,0)
				if recent_button == "X":
					current_space = 48
				else:
					current_space = 11
				PXY.get_node("X11").visible = false
				PXY.get_node("Y11").visible = false
			11:
				PXY.get_node("X12").visible = true
				PXY.get_node("Y12").visible = true
				camera.can_move(true, player_number)
				await XandY
				camera.can_move(false, player_number)
				camera.position = Vector2(0,0)
				if recent_button == "X":
					current_space = 12
				else:
					current_space = 102
				PXY.get_node("X12").visible = false
				PXY.get_node("Y12").visible = false
			18:
				current_space = 101
			22:
				PXY.get_node("X27").visible = true
				PXY.get_node("Y27").visible = true
				camera.can_move(true, player_number)
				await XandY
				camera.can_move(false, player_number)
				camera.position = Vector2(0,0)
				if recent_button == "X":
					current_space = 26
				else:
					current_space = 23
				PXY.get_node("X27").visible = false
				PXY.get_node("Y27").visible = false
			24:
				PXY.get_node("X30").visible = true
				PXY.get_node("Y30").visible = true
				camera.can_move(true, player_number)
				await XandY
				camera.can_move(false, player_number)
				camera.position = Vector2(0,0)
				if recent_button == "X":
					current_space = 25
				else:
					current_space = 60
				PXY.get_node("X30").visible = false
				PXY.get_node("Y30").visible = false
			25:
				current_space = 27
			36:
				PXY.get_node("X44").visible = true
				PXY.get_node("Y44").visible = true
				camera.can_move(true, player_number)
				await XandY
				camera.can_move(false, player_number)
				camera.position = Vector2(0,0)
				if recent_button == "X":
					current_space = 37
				else:
					current_space = 51
				PXY.get_node("X44").visible = false
				PXY.get_node("Y44").visible = false
			41:
				PXY.get_node("X49").visible = true
				PXY.get_node("Y49").visible = true
				camera.can_move(true, player_number)
				await XandY
				camera.can_move(false, player_number)
				camera.position = Vector2(0,0)
				if recent_button == "X":
					current_space = 42
				else:
					current_space = 44
				PXY.get_node("X49").visible = false
				PXY.get_node("Y49").visible = false
			43:
				current_space = 1
			47:
				current_space = 8
			50:
				PXY.get_node("X61").visible = true
				PXY.get_node("Y61").visible = true
				camera.can_move(true, player_number)
				await XandY
				camera.can_move(false, player_number)
				camera.position = Vector2(0,0)
				if recent_button == "X":
					current_space = 59
				else:
					current_space = 51
				PXY.get_node("X61").visible = false
				PXY.get_node("Y61").visible = false
			34:
				PXY.get_node("X64").visible = true
				PXY.get_node("Y64").visible = true
				camera.can_move(true, player_number)
				await XandY
				camera.can_move(false, player_number)
				camera.position = Vector2(0,0)
				if recent_button == "X":
					current_space = 35
				else:
					current_space = 53
				PXY.get_node("X64").visible = false
				PXY.get_node("Y64").visible = false
			55:
				current_space = 103
			58:
				current_space = 101
			59:
				current_space = 37
			62:
				PXY.get_node("X75").visible = true
				PXY.get_node("Y75").visible = true
				camera.can_move(true, player_number)
				await XandY
				camera.can_move(false, player_number)
				camera.position = Vector2(0,0)
				if recent_button == "X":
					current_space = 74
				else:
					current_space = 63
				PXY.get_node("X75").visible = false
				PXY.get_node("Y75").visible = false
			72:
				current_space = 104
			73:
				current_space = 62
			75:
				current_space = 32
			101:
				current_space = 19
			102:
				current_space = 14
			103:
				current_space = 56
			104:
				current_space = 73
			_:
				current_space += 1
		####################
		if current_space < 10:
			space_string = "/root/Campus/Spaces/S00" + str(current_space)
		elif current_space < 100:
			space_string = "/root/Campus/Spaces/S0" + str(current_space)
		else:
			space_string = "/root/Campus/Spaces/S" + str(current_space)
		var new_target = get_node(space_string).global_position + Vector2(55, 65)
		if new_target.x < global_position.x:
			get_node(character).flip_h = true
		else:
			get_node(character).flip_h = false
		var tween = create_tween()
		tween.tween_property(self, "position", new_target, 0.5)
		await get_tree().create_timer(0.5).timeout
		if current_space == Global.starspot:
			if Global.playercoin[player_number] < 10:
				textbox_label_s.text = "You can not afford\nany credits!"
				textbox_s.visible = true
				await AandB
				textbox_s.visible = false
				await get_tree().create_timer(0.5).timeout
				move_spaces(spaces_to_move)
			else:
				await buy_credits()
				await get_tree().create_timer(0.5).timeout
				move_spaces(spaces_to_move)
		elif current_space == 5:
			textbox_label_s.text = "You receive $10\nfrom the president!"
			textbox_s.visible = true
			await AandB
			textbox_s.visible = false
			Global.playercoin[player_number] += 10
			$"../..".update_scores()
			await get_tree().create_timer(0.5).timeout
			move_spaces(spaces_to_move)
		elif current_space < 100:
			die_number.text = str(spaces_to_move-1)
			move_spaces(spaces_to_move-1)
		else:
			if Global.playeritems[player_number][0] == 0 or\
			Global.playeritems[player_number][1] == 0 or\
			Global.playeritems[player_number][2] == 0:
				await use_shop(current_space)
			else:
				textbox_label_s.text = \
				"You are already holding\nthe maximum number\nof items!"
				textbox_s.visible = true
				await AandB
			textbox_s.visible = false
			textbox_shop.visible = false
			await get_tree().create_timer(0.5).timeout
			move_spaces(spaces_to_move)
		
func land_on_current_space():
	match current_space:
		6, 10, 16, 20, 33, 38, 54, 69:#Red
			coin_label.text = "-$3"
			coin_label.visible = true
			Global.playercoin[player_number] = max(0, \
			Global.playercoin[player_number] - 3)
			$"../..".update_scores()
			await get_tree().create_timer(2).timeout
			coin_label.visible = false
			end_turn()
		40, 46, 60, 65, 67, 70, 75:#Adademic
			textbox_label_s.text = \
			"You go to an exciting lecture!\nRoll 1 \
			extra number next turn\nand add it to your movement."
			Global.playerbonusextra[player_number] = 1
			textbox_s.visible = true
			await AandB
			textbox_s.visible = false
			await get_tree().create_timer(2).timeout
			end_turn()
		1, 2, 12, 13, 63, 64:#Shuttle:9th St Main Gate, Howe Circle, Babbio Center
			await shuttle()
			await get_tree().create_timer(2).timeout
			end_turn()
		3, 22, 36, 52, 59, 74:#ResHall
			textbox_label_s.text = \
			"You take a rest in the residence hall!\nRoll 2 \
			extra numbers next turn\nand add them to your movement."
			Global.playerbonusextra[player_number] = 2
			textbox_s.visible = true
			await AandB
			textbox_s.visible = false
			await get_tree().create_timer(2).timeout
			end_turn()
		9, 14, 19, 50, 25, 41, 56, 66, 71:#Good Luck 
			coin_label.text = "+$10"
			coin_label.visible = true
			Global.playercoin[player_number] += 10
			$"../..".update_scores()
			await get_tree().create_timer(2).timeout
			coin_label.visible = false
			end_turn()
		28, 45:#Bad Luck
			coin_label.text = "-$10"
			coin_label.visible = true
			Global.playercoin[player_number] = max(0, \
			Global.playercoin[player_number] - 10)
			$"../..".update_scores()
			await get_tree().create_timer(2).timeout
			coin_label.visible = false
			end_turn()
		8:#Admissions
			await admissions()
			await get_tree().create_timer(2).timeout
			end_turn()
		26:#Walker
			textbox_label_s.text = \
			"You work out in Walker Gymnasium!\nRecieve a bonus in the \
			next\nminigame based on your placement."
			Global.playerbonusextra[player_number] = 6
			textbox_s.visible = true
			await AandB
			textbox_s.visible = false
			await get_tree().create_timer(2).timeout
			end_turn()
		30:#Field
			textbox_label_s.text = \
			"You watch a soccer game!\nRecieve a bonus in the \
			next\nminigame based on your placement."
			Global.playerbonusextra[player_number] = 6
			textbox_s.visible = true
			await AandB
			textbox_s.visible = false
			await get_tree().create_timer(2).timeout
			end_turn()
		42:#CAPS
			await caps()
			await get_tree().create_timer(2).timeout
			end_turn()
		48:#Volleyball
			textbox_label_s.text = \
			"You play some volleyball!\nRecieve a bonus in the \
			next\nminigame based on your placement."
			Global.playerbonusextra[player_number] = 6
			textbox_s.visible = true
			await AandB
			textbox_s.visible = false
			await get_tree().create_timer(2).timeout
			end_turn()
		57:#Library
			await library()
			await get_tree().create_timer(2).timeout
			end_turn()
		_:#Blue
			coin_label.text = "+$3"
			coin_label.visible = true
			Global.playercoin[player_number] += 3
			$"../..".update_scores()
			await get_tree().create_timer(2).timeout
			coin_label.visible = false
			end_turn()
	
func check_items():
	using_item = 0
	z_index = 1
	sum = 0
	if Global.playeritems[player_number][0] != 0 or \
	Global.playeritems[player_number][1] != 0 or \
	Global.playeritems[player_number][2] != 0:
		show_items()
		var selected = false
		while not selected:
			await ABXY
			match recent_button:
				"A":
					if Global.playeritems[player_number][0] != 0:
						selected = true
						await use_item(Global.playeritems[player_number][0])
						Global.playeritems[player_number][0] = 0
						$"../..".hide_item(player_number, 0)
				"X":
					if Global.playeritems[player_number][1] != 0:
						selected = true
						await use_item(Global.playeritems[player_number][1])
						Global.playeritems[player_number][1] = 0
						$"../..".hide_item(player_number, 1)
				"Y":
					if Global.playeritems[player_number][2] != 0:
						selected = true
						await use_item(Global.playeritems[player_number][2])
						Global.playeritems[player_number][2] = 0
						$"../..".hide_item(player_number, 2)
				"B":
					selected = true 
		textbox_item.visible = false
		await get_tree().create_timer(0.4).timeout
		match using_item:
			4:
				item_roll()
			_:
				can_roll = true
				$"../..".start_roll()
	else:
		can_roll = true
		$"../..".start_roll()

func roll():
	get_node(character).play("jump")
	var tween = create_tween()
	tween.tween_property(self, "position", global_position + \
	Vector2(0, -90), 0.25)
	tween.tween_property(self, "position", global_position, 0.25)
	await get_tree().create_timer(0.25).timeout
	die_number.visible = false
	bonus_number.visible = false
	$"../../Number_Timer".stop()
	await get_tree().create_timer(0.25).timeout
	get_node(character).play("idle")
	await get_tree().create_timer(1).timeout 
	var random_number = randi_range(1, 10)
	if Global.playerbonusroll[player_number] > 0:
		random_number += Global.playerbonusroll[player_number]
		Global.playerbonusroll[player_number] = 0
	die_number.text = str(random_number)
	die_number.visible = true
	sum += random_number
	await get_tree().create_timer(1).timeout 
	if Global.playerbonusextra[player_number] == 1:
		Global.playerbonusextra[player_number] = 0
		can_roll = true
		$"../..".start_roll()
	elif Global.playerbonusextra[player_number] == 2:
		Global.playerbonusextra[player_number] = 1
		can_roll = true
		$"../..".start_roll()
	else:
		laptop.visible = false
		die_number.text = str(sum)
		camera.reparent(self)
		move_spaces(sum) 
		
func show_items():
	textbox_item.visible = true
	if Global.playeritems[player_number][0] == 0:
		item_A.visible = false
	else:
		item_A.visible = true
		item_A.get_node("Items").hide_sprites()
		item_A.get_node("Items").get_child(Global.playeritems\
		[player_number][0] - 1).visible = true
		match Global.playeritems[player_number][0]:
			1:
				item_A.get_node("A_Label").text = "Add 10\nto your\nroll."
			2:
				item_A.get_node("A_Label").text = "Add 5\nto your\nroll."
			3:
				item_A.get_node("A_Label").text = "Add 3\nto your\nroll."
			4:
				item_A.get_node("A_Label").text = "Choose what\nnumber\nyou roll."
			5:
				item_A.get_node("A_Label").text = "Roll values\n1, \
				2, or 3\n8 times."
			6:
				item_A.get_node("A_Label").text = "Roll 2\nvalues \
				and\nchoose 1."
			7:
				item_A.get_node("A_Label").text = "Warp \
				to\njust before\nthe credits."
			8:
				item_A.get_node("A_Label").text = "Roll a\n1, 2, 9,\nor 10."
	if Global.playeritems[player_number][1] == 0:
		item_X.visible = false
	else:
		item_X.visible = true
		item_X.get_node("Items").hide_sprites()
		item_X.get_node("Items").get_child(Global.playeritems\
		[player_number][1] - 1).visible = true
		match Global.playeritems[player_number][1]:
			1:
				item_X.get_node("X_Label").text = "Add 10\nto your\nroll."
			2:
				item_X.get_node("X_Label").text = "Add 5\nto your\nroll."
			3:
				item_X.get_node("X_Label").text = "Add 3\nto your\nroll."
			4:
				item_X.get_node("X_Label").text = "Choose what\nnumber\nyou roll."
			5:
				item_X.get_node("X_Label").text = "Roll values\n1, \
				2, or 3\n8 times."
			6:
				item_X.get_node("X_Label").text = "Roll 2\nvalues \
				and\nchoose 1."
			7:
				item_X.get_node("X_Label").text = "Warp \
				to\njust before\nthe credits."
			8:
				item_X.get_node("X_Label").text = "Roll a\n1, 2, 9,\nor 10."
	if Global.playeritems[player_number][2] == 0:
		item_Y.visible = false
	else:
		item_Y.visible = true
		item_Y.get_node("Items").hide_sprites()
		item_Y.get_node("Items").get_child(Global.playeritems\
		[player_number][2] - 1).visible = true
		match Global.playeritems[player_number][2]:
			1:
				item_Y.get_node("Y_Label").text = "Add 10\nto your\nroll."
			2:
				item_Y.get_node("Y_Label").text = "Add 5\nto your\nroll."
			3:
				item_Y.get_node("Y_Label").text = "Add 3\nto your\nroll."
			4:
				item_Y.get_node("Y_Label").text = "Choose what\nnumber\nyou roll."
			5:
				item_Y.get_node("Y_Label").text = "Roll values\n1, \
				2, or 3\n8 times."
			6:
				item_Y.get_node("Y_Label").text = "Roll 2\nvalues \
				and\nchoose 1."
			7:
				item_Y.get_node("Y_Label").text = "Warp \
				to\njust before\nthe credits."
			8:
				item_Y.get_node("Y_Label").text = "Roll a\n1, 2, 9,\nor 10."

func end_turn():
	z_index = 0
	Global.playerflipped[player_number] = get_node(character).flip_h
	$"../..".next_turn()

func use_shop(shop_num):
	shop_A.get_node("Items").hide_sprites()
	shop_X.get_node("Items").hide_sprites()
	shop_Y.get_node("Items").hide_sprites()
	match shop_num:
		101:
			shop_A.get_node("Items").get_child(2-1).visible = true
			shop_A.get_node("A_Price").text = "$4"
			shop_A.get_node("A_Label").text = "Add 5\nto your\nroll."
			shop_X.get_node("Items").get_child(6-1).visible = true
			shop_X.get_node("X_Price").text = "$6"
			shop_X.get_node("X_Label").text = "Roll 2\nvalues \
				and\nchoose 1."
			shop_Y.get_node("Items").get_child(5-1).visible = true
			shop_Y.get_node("Y_Price").text = "$8"
			shop_Y.get_node("Y_Label").text = "Roll values\n1, \
				2, or 3\n8 times."
		102:
			shop_A.get_node("Items").get_child(1-1).visible = true
			shop_A.get_node("A_Price").text = "$7"
			shop_A.get_node("A_Label").text = "Add 10\nto your\nroll."
			shop_X.get_node("Items").get_child(9-1).visible = true
			shop_X.get_node("X_Price").text = "$20"
			shop_X.get_node("X_Label").text = "Sandwich,\nPizza, and\nBurger."
			shop_Y.get_node("Items").get_child(7-1).visible = true
			shop_Y.get_node("Y_Price").text = "$25"
			shop_Y.get_node("Y_Label").text = "Warp \
				to\njust before\nthe credits."
		103:
			shop_A.get_node("Items").get_child(3-1).visible = true
			shop_A.get_node("A_Price").text = "$2"
			shop_A.get_node("A_Label").text = "Add 3\nto your\nroll."
			shop_X.get_node("Items").get_child(1-1).visible = true
			shop_X.get_node("X_Price").text = "$7"
			shop_X.get_node("X_Label").text = "Add 10\nto your\nroll."
			shop_Y.get_node("Items").get_child(4-1).visible = true
			shop_Y.get_node("Y_Price").text = "$12"
			shop_Y.get_node("Y_Label").text = "Choose what\nnumber\nyou roll."
		104:
			shop_A.get_node("Items").get_child(8-1).visible = true
			shop_A.get_node("A_Price").text = "$3"
			shop_A.get_node("A_Label").text = "Roll a\n1, 2, 9,\nor 10."
			shop_X.get_node("Items").get_child(1-1).visible = true
			shop_X.get_node("X_Price").text = "$7"
			shop_X.get_node("X_Label").text = "Add 10\nto your\nroll."
			shop_Y.get_node("Items").get_child(4-1).visible = true
			shop_Y.get_node("Y_Price").text = "$12"
			shop_Y.get_node("Y_Label").text = "Choose what\nnumber\nyou roll."
	textbox_shop.visible = true
	var picked = false
	var item_num = 0
	while(not picked):
		await ABXY
		match recent_button:
			"A":
				match shop_num:
					101:
						if Global.playercoin[player_number] >= 4:
							Global.playercoin[player_number] -= 4
							item_num = 2
							picked = true
					102:
						if Global.playercoin[player_number] >= 7:
							Global.playercoin[player_number] -= 7
							item_num = 1
							picked = true
					103:
						if Global.playercoin[player_number] >= 2:
							Global.playercoin[player_number] -= 2
							item_num = 3
							picked = true
					104:
						if Global.playercoin[player_number] >= 3:
							Global.playercoin[player_number] -= 3
							item_num = 8
							picked = true
			"X":
				match shop_num:
					101:
						if Global.playercoin[player_number] >= 6:
							Global.playercoin[player_number] -= 6
							item_num = 6
							picked = true
					102:
						if Global.playercoin[player_number] >= 20:
							Global.playercoin[player_number] -= 20
							item_num = 9
							picked = true
					103, 104:
						if Global.playercoin[player_number] >= 7:
							Global.playercoin[player_number] -= 7
							item_num = 1
							picked = true
			"Y":
				match shop_num:
					101:
						if Global.playercoin[player_number] >= 8:
							Global.playercoin[player_number] -= 8
							item_num = 5
							picked = true
					102:
						if Global.playercoin[player_number] >= 25:
							Global.playercoin[player_number] -= 25
							item_num = 7
							picked = true
					103, 104:
						if Global.playercoin[player_number] >= 12:
							Global.playercoin[player_number] -= 12
							item_num = 4
							picked = true
			"B":
				picked = true
	if item_num == 9:
		if Global.playeritems[player_number][0] == 0:
			Global.playeritems[player_number][0] = 4
		elif Global.playeritems[player_number][1] == 0:
			Global.playeritems[player_number][1] = 4
		else:
			Global.playeritems[player_number][2] = 4
		if Global.playeritems[player_number][1] == 0:
			Global.playeritems[player_number][1] = 5
		elif Global.playeritems[player_number][2] == 0:
			Global.playeritems[player_number][2] = 5
		if Global.playeritems[player_number][2] == 0:
			Global.playeritems[player_number][2] = 2
	else:
		if Global.playeritems[player_number][0] == 0:
			Global.playeritems[player_number][0] = item_num
		elif Global.playeritems[player_number][1] == 0:
			Global.playeritems[player_number][1] = item_num
		else:
			Global.playeritems[player_number][2] = item_num
	$"../..".update_scores()

func shuttle():
	textbox_label_l.text = \
	"Where would you like the\nStevens Shuttle to take you?"
	y_label.text = "Anywhere!"
	b_label.text = "Pass."
	if current_space < 3:
		a_label.text = "Howe Circle."
		x_label.text = "Babbio Center."
		textbox_l.visible = true
		await ABXY
		textbox_l.visible = false
		match recent_button:
			"A":
				current_space = 13
			"X":
				current_space = 64
			"Y":
				current_space = random_space(1, 75, 1, 2, Global.starspot, 5)
			"B":
				return 
	elif current_space < 14:
		a_label.text = "9th Street Main Gate."
		x_label.text = "Babbio Center."
		textbox_l.visible = true
		await ABXY
		textbox_l.visible = false
		match recent_button:
			"A":
				current_space = 2
			"X":
				current_space = 64
			"Y":
				current_space = random_space(1, 75, 12, 13, Global.starspot, 5)
			"B":
				return 
	else:
		a_label.text = "9th Street Main Gate."
		x_label.text = "Howe Circle."
		textbox_l.visible = true
		await ABXY
		textbox_l.visible = false
		match recent_button:
			"A":
				current_space = 2
			"X":
				current_space = 13
			"Y":
				current_space = random_space(1, 75, 63, 64, Global.starspot, 5)
			"B":
				return 
	if current_space < 10:
		space_string = "/root/Campus/Spaces/S00" + str(current_space)
	elif current_space < 100:
		space_string = "/root/Campus/Spaces/S0" + str(current_space)
	else:
		space_string = "/root/Campus/Spaces/S" + str(current_space)
	var new_target = get_node(space_string).global_position + Vector2(55, 65)
	camera.reparent($"../..")
	$"../../AP".play("fade_out")
	await get_tree().create_timer(1.2).timeout
	var tween = create_tween()
	tween.tween_property(self, "position", new_target, 0.5)
	await get_tree().create_timer(0.5).timeout
	camera.reparent(self)
	camera.position = Vector2(0,0)
	camera.reparent($"../..")
	$"../../AP".play("fade_in_simple")
	await get_tree().create_timer(1.1).timeout
	camera.reparent(self)

func caps():
	textbox_label_l.text = \
	"Welcome to CAPS!\nWhat can we help with today?"
	a_label.text = "Physical health: Recieve a\nbonus in the next minigame."
	x_label.text = "Mental health:\nRoll 2 extra numbers next turn."
	y_label.text = "Financial health?\nGain $5 Duckbills."
	b_label.text = "Pass."
	textbox_l.visible = true
	await ABXY
	match recent_button:
		"A":
			Global.playerbonusextra[player_number] = 6
		"X":
			Global.playerbonusextra[player_number] = 2
		"Y":
			Global.playercoin[player_number] += 5
			$"../..".update_scores()
		"B":
			pass 
	textbox_l.visible = false

func library():
	if Global.playercoin[player_number] < 15:
		textbox_label_s.text = "You do not have enough\nDuckbills \
		to pay for a tutor."
		textbox_s.visible = true
		await AandB
		textbox_s.visible = false
		return
	else:
		textbox_label_l.text = \
		"Pay a tutor $15 to\nrecieve 2 credits?"
		b_label.text = "Pass."
		match player_number:
			1:
				a_label.text = "Player 2."
				x_label.text = "Player 3."
				y_label.text = "Player 4."
			2:
				a_label.text = "Player 1."
				x_label.text = "Player 3."
				y_label.text = "Player 4."
			3:
				a_label.text = "Player 1."
				x_label.text = "Player 2."
				y_label.text = "Player 4."
			4:
				a_label.text = "Player 1."
				x_label.text = "Player 2."
				y_label.text = "Player 3."
		textbox_l.visible = true
		await ABXY
		var tutor = 0
		match recent_button:
			"A":
				match player_number:
					1:
						tutor = 2
					_:
						tutor = 1
			"X":
				match player_number:
					1, 2:
						tutor = 3
					_:
						tutor = 2
			"Y":
				match player_number:
					4:
						tutor = 3
					_:
						tutor = 4
			"B":
				textbox_l.visible = false
				return 
		Global.playercoin[player_number] -= 15
		Global.playercoin[tutor] += 15
		Global.playerstar[player_number] += 2
		$"../..".update_scores()
		textbox_l.visible = false

func admissions():
	textbox_a.visible = true
	var selected = false
	var Asum = 0
	while not selected:
		await ABXY
		match recent_button:
			"A":
				selected = true
				var i = 1
				while i <= 4:
					if player_number != i:
						if Global.playercoin[i] <= 5:
							Asum += Global.playercoin[i]
							Global.playercoin[i] = 0
						else:
							Asum += 5
							Global.playercoin[i] -= 5
					i += 1
				Global.playercoin[player_number] += Asum
				$"../..".update_scores()
			"X":
				if Global.playercoin[player_number] >= 50:
					Global.playercoin[player_number] -= 50
					selected = true
					var i = 1
					while i <= 4:
						if player_number != i and Global.playerstar[i] != 0:
							Global.playerstar[i] -= 1
							Asum += 1
						i += 1
					Global.playerstar[player_number] += Asum
					$"../..".update_scores()
			"Y":
				pass
			"B":
				selected = true
	textbox_a.visible = false
	return

func use_item(item_num):
	match item_num:
		1:
			Global.playerbonusroll[player_number] += 10
		2:
			Global.playerbonusroll[player_number] += 5
		3:
			Global.playerbonusroll[player_number] += 3
		4:
			using_item = 4
			Global.playerbonusextra[player_number] = 0
			Global.playerbonusroll[player_number] = 0
		5:
			using_item = 5
		6:
			using_item = 6
			Global.playerbonusextra[player_number] = 0
			Global.playerbonusroll[player_number] = 0
		7:
			textbox_item.visible = false
			if Global.starspot == 44:
				current_space = 41
			else:
				current_space = Global.starspot - 1
			if current_space < 10:
				space_string = "/root/Campus/Spaces/S00" + str(current_space)
			elif current_space < 100:
				space_string = "/root/Campus/Spaces/S0" + str(current_space)
			else:
				space_string = "/root/Campus/Spaces/S" + str(current_space)
			var new_target = get_node(space_string).global_position + Vector2(55, 65)
			camera.reparent($"../..")
			$"../../AP".play("fade_out")
			await get_tree().create_timer(1.2).timeout
			var tween = create_tween()
			tween.tween_property(self, "position", new_target, 0.5)
			await get_tree().create_timer(0.5).timeout
			camera.reparent(self)
			camera.position = Vector2(0,0)
			camera.reparent($"../..")
			$"../../AP".play("fade_in_simple")
			await get_tree().create_timer(1.1).timeout
		8:
			using_item = 8
			Global.playerbonusextra[player_number] = 0
			Global.playerbonusroll[player_number] = 0

func buy_credits():
	textbox_label_l.text = "Spend Duckbills\nto earn Credits!"
	a_label.text = "$10 for 1 credit."
	x_label.text = "$20 for 3 credits."
	y_label.text = "$30 for 4 credits."
	textbox_l.visible = true
	var chosen = false
	while not chosen:
		await ABXY
		match recent_button:
			"A":
				chosen = true
				Global.playercoin[player_number] -= 10
				Global.playerstar[player_number] += 1
			"X":
				if Global.playercoin[player_number] >= 20:
					chosen = true
					Global.playercoin[player_number] -= 20
					Global.playerstar[player_number] += 3
			"Y":
				if Global.playercoin[player_number] >= 30:
					chosen = true
					Global.playercoin[player_number] -= 30
					Global.playerstar[player_number] += 4
			"B":
				chosen = true
				textbox_l.visible = false
				return
	textbox_l.visible = false
	$"../..".update_scores()
	await get_tree().create_timer(1).timeout
	die_number.visible = false
	await $"../..".new_star(current_space)
	die_number.visible = true	
	
func random_space(start_range, end_range, not1, not2, not3, not4):
	var num = not1
	while num == not1 or num == not2 or num == not3 or num == not4:
		num = randi_range(start_range, end_range)
	return num

func item_roll():
	bonus_number.text = ""
	match using_item:
		4:
			$"../../Camera/CanvasLayer/CustomDie/CusNum".text = "5"
			$"../../Camera/CanvasLayer/CustomDie".visible = true
			recent_button = ""
			var custom_num = 5
			camera.can_move(true, player_number)
			while recent_button != "A":
				await ABXY
				if recent_button == "Y":
					custom_num += 1
					if custom_num == 11:
						custom_num = 1
				elif recent_button == "X":
					custom_num -= 1
					if custom_num == 0:
						custom_num = 10
				$"../../Camera/CanvasLayer/CustomDie/CusNum".text = str(custom_num)
			camera.can_move(false, player_number)
			camera.reparent(self)
			camera.position = Vector2(0,0)
			camera.reparent($"../..")
			get_node(character).play("jump")
			var tween = create_tween()
			tween.tween_property(self, "position", global_position + \
			Vector2(0, -90), 0.25)
			tween.tween_property(self, "position", global_position, 0.25)
			await get_tree().create_timer(0.25).timeout
			$"../../Camera/CanvasLayer/CustomDie".visible = false
			await get_tree().create_timer(0.25).timeout
			get_node(character).play("idle")
			await get_tree().create_timer(1).timeout 
			die_number.text = str(custom_num)
			die_number.visible = true
			await get_tree().create_timer(1).timeout 
			laptop.visible = false
			die_number.text = str(custom_num)
			camera.reparent(self)
			move_spaces(custom_num)
		5:
			get_node(character).play("jump")
			var tween = create_tween()
			tween.tween_property(self, "position", global_position + \
			Vector2(0, -90), 0.25)
			tween.tween_property(self, "position", global_position, 0.25)
			await get_tree().create_timer(0.25).timeout
			die_number.visible = false
			bonus_number.visible = false
			$"../../Number_Timer".stop()
			await get_tree().create_timer(0.2).timeout
			get_node(character).play("idle")
			await get_tree().create_timer(0.5).timeout 
			var random_number = randi_range(1, 3)
			if Global.playerbonusroll[player_number] > 0:
				random_number += Global.playerbonusroll[player_number]
				Global.playerbonusroll[player_number] = 0
			die_number.text = str(random_number)
			die_number.visible = true
			sum += random_number
			pizza -= 1
			await get_tree().create_timer(0.3).timeout 
			if pizza != 0:
				can_roll = true
				$"../..".start_roll()
			else:
				laptop.visible = false
				die_number.text = str(sum)
				camera.reparent(self)
				move_spaces(sum)
		6:
			get_node(character).play("jump")
			var tween = create_tween()
			tween.tween_property(self, "position", global_position + \
			Vector2(0, -90), 0.25)
			tween.tween_property(self, "position", global_position, 0.25)
			await get_tree().create_timer(0.25).timeout
			die_number.visible = false
			bonus_number.visible = false
			$"../../Number_Timer".stop()
			await get_tree().create_timer(0.25).timeout
			get_node(character).play("idle")
			await get_tree().create_timer(1).timeout 
			var random_number = 0
			if taco == 2:
				random_number = randi_range(1, 10)
				sum = random_number
			else:
				random_number = randi_range(1, 9)
				if random_number == sum:
					random_number = 10
			die_number.text = str(random_number)
			die_number.visible = true
			taco -= 1
			await get_tree().create_timer(1).timeout 
			if taco == 1:
				can_roll = true
				$"../..".start_roll()
			else:
				laptop.visible = false
				die_number.visible = false
				$"../../Camera/CanvasLayer/TacoDie/TacoNum1".text = str(sum)
				$"../../Camera/CanvasLayer/TacoDie/TacoNum2".text =\
				str(random_number)
				$"../../Camera/CanvasLayer/TacoDie".visible = true
				camera.can_move(true, player_number)
				await XandY
				camera.can_move(false, player_number)
				$"../../Camera/CanvasLayer/TacoDie".visible = false
				camera.reparent(self)
				camera.position = Vector2(0,0)
				if recent_button == "X":
					die_number.text = str(sum)
					die_number.visible = true
					move_spaces(sum)
				else:
					die_number.text = str(random_number)
					die_number.visible = true
					move_spaces(random_number)
		8:
			get_node(character).play("jump")
			var tween = create_tween()
			tween.tween_property(self, "position", global_position + \
			Vector2(0, -90), 0.25)
			tween.tween_property(self, "position", global_position, 0.25)
			await get_tree().create_timer(0.25).timeout
			die_number.visible = false
			bonus_number.visible = false
			$"../../Number_Timer".stop()
			await get_tree().create_timer(0.25).timeout
			get_node(character).play("idle")
			await get_tree().create_timer(1).timeout 
			var random_number = randi_range(1, 4)
			match random_number:
				3:
					random_number = 9
				4:
					random_number = 10
			die_number.text = str(random_number)
			die_number.visible = true
			sum += random_number
			await get_tree().create_timer(1).timeout 
			laptop.visible = false
			die_number.text = str(sum)
			camera.reparent(self)
			move_spaces(sum)

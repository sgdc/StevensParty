extends Control

var player_sel = [null, 0,0,0,0] #ALL 0s
var char_select = false
var player_spot = [null, 1, 2, 3, 4]

var turns = 15
var start = false
var htp = false
var cred = false

var cooldown = [null,false,false,false,false]

@onready var first_player_selector = $CharacterSelect/First_player_selector
var fps_pos = [null, Vector2(45,54), Vector2(415,54), Vector2(785,54), \
	Vector2(1155,54), Vector2(1525,54), Vector2(45,424), Vector2(415,424), \
	Vector2(785,424), Vector2(1155,424), Vector2(1525,424)]

var pickable_pos = [null, fps_pos[1], fps_pos[2], fps_pos[3], fps_pos[4]]

func _ready():
	set_colors()
	Global.reset()
	$CharacterSelect.visible = false
	$AP.play("fade_in")
	$PlayButton.grab_focus()
	
func set_colors():
	$CharacterSelect/Selector1.color = Global.blue
	$CharacterSelect/Selector2.color = Global.red
	$CharacterSelect/Selector3.color = Global.green
	$CharacterSelect/Selector4.color = Global.yellow

func _on_play_button_pressed() -> void:
	if not htp and not cred:
		$CharacterSelect.visible = true
		char_select = true
		$PlayButton.release_focus()

func _on_start_button_pressed() -> void:
	if player_sel[1] != 0 and player_sel[2] != 0 and player_sel[3] != 0 and \
	player_sel[4] != 0:
		start = true
		Global.lastturn = turns
		set_characters()
		select_first_player()

func _on_back_pressed() -> void:
	$CharacterSelect.visible = false 
	player_sel = [null, 0, 0, 0, 0]
	char_select = false
	$PlayButton.grab_focus()
	
func _input(event: InputEvent) -> void:
	if event.is_action_released("b1") and htp:
		htp = false
		$HTPButton.grab_focus()
		$HowToPlay.visible = false
	elif event.is_action_released("b1") and cred:
		cred = false
		$CreditsButton.grab_focus()
		$Credits.visible = false
	elif char_select and event.is_action_released("b1") and player_sel[1] == 0:
		_on_back_pressed() 
	elif char_select and not start:
		if not cooldown[1]:
			if Input.is_action_just_pressed("left1") and player_spot[1] != 1 and \
			player_spot[1] != 6 and player_sel[1] == 0:
				cooldown[1] = true
				$MoveTimer1.start()
				player_spot[1] -= 1
				$CharacterSelect/Selector1.position.x -= 370
			elif Input.is_action_just_pressed("right1") and player_spot[1] != 5 and \
			player_spot[1] != 10 and player_sel[1] == 0:
				cooldown[1] = true
				$MoveTimer1.start()
				player_spot[1] += 1
				$CharacterSelect/Selector1.position.x += 370
			elif Input.is_action_just_pressed("up1") and player_spot[1] >= 6 and \
			player_sel[1] == 0:
				cooldown[1] = true
				$MoveTimer1.start()
				player_spot[1] -= 5
				$CharacterSelect/Selector1.position.y -= 370
			elif Input.is_action_just_pressed("down1") and player_spot[1] <= 5 and \
			player_sel[1] == 0:
				cooldown[1] = true
				$MoveTimer1.start()
				player_spot[1] += 5
				$CharacterSelect/Selector1.position.y += 370
		if not cooldown[2]:
			if Input.is_action_just_pressed("left2") and player_spot[2] != 1 and \
			player_spot[2] != 6 and player_sel[2] == 0:
				cooldown[2] = true
				$MoveTimer2.start()
				player_spot[2] -= 1
				$CharacterSelect/Selector2.position.x -= 370
			elif Input.is_action_just_pressed("right2") and player_spot[2] != 5 and \
			player_spot[2] != 10 and player_sel[2] == 0:
				cooldown[2] = true
				$MoveTimer2.start()
				player_spot[2] += 1
				$CharacterSelect/Selector2.position.x += 370
			elif Input.is_action_just_pressed("up2") and player_spot[2] >= 6 and \
			player_sel[2] == 0:
				cooldown[2] = true
				$MoveTimer2.start()
				player_spot[2] -= 5
				$CharacterSelect/Selector2.position.y -= 370
			elif Input.is_action_just_pressed("down2") and player_spot[2] <= 5 and \
			player_sel[2] == 0:
				cooldown[2] = true
				$MoveTimer2.start()
				player_spot[2] += 5
				$CharacterSelect/Selector2.position.y += 370
		if not cooldown[3]:
			if Input.is_action_just_pressed("left3") and player_spot[3] != 1 and \
			player_spot[3] != 6 and player_sel[3] == 0:
				cooldown[3] = true
				$MoveTimer3.start()
				player_spot[3] -= 1
				$CharacterSelect/Selector3.position.x -= 370
			elif Input.is_action_just_pressed("right3") and player_spot[3] != 5 and \
			player_spot[3] != 10 and player_sel[3] == 0:
				cooldown[3] = true
				$MoveTimer3.start()
				player_spot[3] += 1
				$CharacterSelect/Selector3.position.x += 370
			elif Input.is_action_just_pressed("up3") and player_spot[3] >= 6 and \
			player_sel[3] == 0:
				cooldown[3] = true
				$MoveTimer3.start()
				player_spot[3] -= 5
				$CharacterSelect/Selector3.position.y -= 370
			elif Input.is_action_just_pressed("down3") and player_spot[3] <= 5 and \
			player_sel[3] == 0:
				cooldown[3] = true
				$MoveTimer3.start()
				player_spot[3] += 5
				$CharacterSelect/Selector3.position.y += 370
		if not cooldown[4]:
			if Input.is_action_just_pressed("left4") and player_spot[4] != 1 and \
			player_spot[4] != 6 and player_sel[4] == 0:
				cooldown[4] = true
				$MoveTimer4.start()
				player_spot[4] -= 1
				$CharacterSelect/Selector4.position.x -= 370
			elif Input.is_action_just_pressed("right4") and player_spot[4] != 5 and \
			player_spot[4] != 10 and player_sel[4] == 0:
				cooldown[4] = true
				$MoveTimer4.start()
				player_spot[4] += 1
				$CharacterSelect/Selector4.position.x += 370
			elif Input.is_action_just_pressed("up4") and player_spot[4] >= 6 and \
			player_sel[4] == 0:
				cooldown[4] = true
				$MoveTimer4.start()
				player_spot[4] -= 5
				$CharacterSelect/Selector4.position.y -= 370
			elif Input.is_action_just_pressed("down4") and player_spot[4] <= 5 and \
			player_sel[4] == 0:
				cooldown[4] = true
				$MoveTimer4.start()
				player_spot[4] += 5
				$CharacterSelect/Selector4.position.y += 370
		if event.is_action_released("a1") and player_sel[1] == 0 and \
		player_spot[1] != player_sel[2] and player_spot[1] != player_sel[3] and \
		player_spot[1] != player_sel[4]:
			player_sel[1] = player_spot[1]
			var get_button = "CharacterSelect/CharButtons/CharButton" + \
			str(player_spot[1])
			get_node(get_button).get_theme_stylebox("disabled").bg_color \
			= Global.blue
			get_node(get_button).disabled = true
		elif event.is_action_released("b1") and player_sel[1] != 0:
			player_sel[1] = 0
			var get_button = "CharacterSelect/CharButtons/CharButton" + \
			str(player_spot[1])
			get_node(get_button).disabled = false
		elif event.is_action_released("a2") and player_sel[2] == 0 and \
		player_spot[2] != player_sel[1] and player_spot[2] != player_sel[3] and \
		player_spot[2] != player_sel[4]:
			player_sel[2] = player_spot[2]
			var get_button = "CharacterSelect/CharButtons/CharButton" + \
			str(player_spot[2])
			get_node(get_button).get_theme_stylebox("disabled").bg_color \
			= Global.red
			get_node(get_button).disabled = true
		elif event.is_action_released("b2") and player_sel[2] != 0:
			player_sel[2] = 0
			var get_button = "CharacterSelect/CharButtons/CharButton" + \
			str(player_spot[2])
			get_node(get_button).disabled = false
		elif event.is_action_released("a3") and player_sel[3] == 0 and \
		player_spot[3] != player_sel[1] and player_spot[3] != player_sel[2] and \
		player_spot[3] != player_sel[4]:
			player_sel[3] = player_spot[3]
			var get_button = "CharacterSelect/CharButtons/CharButton" + \
			str(player_spot[3])
			get_node(get_button).get_theme_stylebox("disabled").bg_color \
			= Global.green
			get_node(get_button).disabled = true
		elif event.is_action_released("b3") and player_sel[3] != 0:
			player_sel[3] = 0
			var get_button = "CharacterSelect/CharButtons/CharButton" + \
			str(player_spot[3])
			get_node(get_button).disabled = false
		elif event.is_action_released("a4") and player_sel[4] == 0 and \
		player_spot[4] != player_sel[1] and player_spot[4] != player_sel[2] and \
		player_spot[4] != player_sel[3]:
			player_sel[4] = player_spot[4]
			var get_button = "CharacterSelect/CharButtons/CharButton" + \
			str(player_spot[4])
			get_node(get_button).get_theme_stylebox("disabled").bg_color \
			= Global.yellow
			get_node(get_button).disabled = true
		elif event.is_action_released("b4") and player_sel[4] != 0:
			player_sel[4] = 0
			var get_button = "CharacterSelect/CharButtons/CharButton" + \
			str(player_spot[4])
			get_node(get_button).disabled = false
		elif event.is_action_released("x1"):
			_on_start_button_pressed()
		elif event.is_action_released("lb1") and turns > 8:
			turns -= 1
			$CharacterSelect/Turns.text = "Turns: " + str(turns)
			$CharacterSelect/Turns/time.text = "About "+str(turns*5)+" minutes"
		elif event.is_action_released("rb1") and turns < 30:
			turns += 1
			$CharacterSelect/Turns.text = "Turns: " + str(turns)
			$CharacterSelect/Turns/time.text = "About "+str(turns*5)+" minutes"
		if player_sel[1] == 0 or player_sel[2] == 0 or player_sel[3] == 0 or \
		player_sel[4] == 0:
			$CharacterSelect/StartButton.disabled = true
		else:
			$CharacterSelect/StartButton.disabled = false
		
func set_characters():
	var i = 1
	while i <= 4:
		match player_sel[i]:
			1:
				Global.playerchar[i] = "Penguin"
				Global.playercharnum[i] = 1
				pickable_pos[i] = fps_pos[1]
			2:
				Global.playerchar[i] = "Hunter"
				Global.playercharnum[i] = 2
				pickable_pos[i] = fps_pos[2]
			3:
				Global.playerchar[i] = "Watch"
				Global.playercharnum[i] = 3
				pickable_pos[i] = fps_pos[3]
			4:
				Global.playerchar[i] = "Thief"
				Global.playercharnum[i] = 4
				pickable_pos[i] = fps_pos[4]
			5:
				Global.playerchar[i] = "Wizard"
				Global.playercharnum[i] = 5
				pickable_pos[i] = fps_pos[5]
			6:
				Global.playerchar[i] = "Rabbit"
				Global.playercharnum[i] = 6
				pickable_pos[i] = fps_pos[6]
			7:
				Global.playerchar[i] = "Bobby"
				Global.playercharnum[i] = 7
				pickable_pos[i] = fps_pos[7]
			8:
				Global.playerchar[i] = "FaraOrst"
				Global.playercharnum[i] = 8
				pickable_pos[i] = fps_pos[8]
			9:
				Global.playerchar[i] = "Aria"
				Global.playercharnum[i] = 9
				pickable_pos[i] = fps_pos[9]
			10:
				Global.playerchar[i] = "Peepers"
				Global.playercharnum[i] = 10
				pickable_pos[i] = fps_pos[10]
		i += 1

func select_first_player():
	first_player_selector.global_position = pickable_pos[1]
	first_player_selector.visible = true
	var random_number = randi_range(9, 12)
	var i = 0
	var pos = 4
	while i < random_number:
		pos += 1
		if pos == 5:
			pos = 1
		first_player_selector.global_position = pickable_pos[pos]
		await get_tree().create_timer(.3).timeout
		i += 1
	Global.firstplayer = pos
	Global.playerturn = pos
	if pos == 1:
		Global.lastplayer = 4
	else:
		Global.lastplayer = pos-1 
	await get_tree().create_timer(1).timeout
	$AP.play("fade_out")
	
func start_game():
	Global.switch_scene("res://Board/Scenes/campus.tscn")
	
func _on_htp_button_pressed() -> void:
	if not htp and not cred:
		htp = true
		$HowToPlay.visible = true

func _on_credits_button_button_up() -> void:
	if not htp and not cred:
		cred = true
		$Credits.visible = true


func _on_move_timer_1_timeout() -> void:
	cooldown[1] = false

func _on_move_timer_2_timeout() -> void:
	cooldown[2] = false

func _on_move_timer_3_timeout() -> void:
	cooldown[3] = false

func _on_move_timer_4_timeout() -> void:
	cooldown[4] = false

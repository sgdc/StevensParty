extends Camera2D

var move = false
var left = ""
var right = ""
var up = ""
var down = ""
var sens = 400.0

func can_move(gold, player_number):
	move = gold
	if move:
		match player_number:
			1:
				left = "left1"
				right = "right1"
				up = "up1"
				down = "down1"
			2:
				left = "left2"
				right = "right2"
				up = "up2"
				down = "down2"
			3:
				left = "left3"
				right = "right3"
				up = "up3"
				down = "down3"
			4:
				left = "left4"
				right = "right4"
				up = "up4"
				down = "down4"

func _process(delta: float) -> void:
	if move:
		var direction : Vector2
		var movement : Vector2
			
		direction.x = Input.get_action_strength(right)-Input.get_action_strength(left)
		direction.y = Input.get_action_strength(down)-Input.get_action_strength(up)
			
		if abs(direction.x) == 1 and abs(direction.y) == 1:
			direction = direction.normalized()
			
		movement = sens * direction * delta
		
		position += movement

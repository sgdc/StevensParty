extends Area2D

var sens= 800.0

var left = ""
var right = ""
var up = ""
var down = ""
var a = ""
var b = ""
var x = ""
var y = ""
var player_number = 0

@onready var main = $"../.."

var colors = ["res://Minigames/General/Assets/BlueCursor.png",\
"res://Minigames/General/Assets/RedCursor.png",\
"res://Minigames/General/Assets/GreenCursor.png",\
"res://Minigames/General/Assets/YellowCursor.png"]

var current_hover = null

func _ready() -> void:
	if name.contains("1"):
		$Sprite2D.texture = load(colors[0])
		left = "left1"
		right = "right1"
		up = "up1"
		down = "down1"
		a = "a1"
		b = "b1"
		x = "x1"
		y = "y1"
		player_number = 1
	elif name.contains("2"):
		$Sprite2D.texture = load(colors[1])
		left = "left2"
		right = "right2"
		up = "up2"
		down = "down2"
		a = "a2"
		b = "b2"
		x = "x2"
		y = "y2"
		player_number = 2
	elif name.contains("3"):
		$Sprite2D.texture = load(colors[2])
		left = "left3"
		right = "right3"
		up = "up3"
		down = "down3"
		a = "a3"
		b = "b3"
		x = "x3"
		y = "y3"
		player_number = 3
	elif name.contains("4"):
		$Sprite2D.texture = load(colors[3])
		left = "left4"
		right = "right4"
		up = "up4"
		down = "down4"
		a = "a4"
		b = "b4"
		x = "x4"
		y = "y4"
		player_number = 4
	
func _process(delta: float) -> void:
	var direction : Vector2
	var movement : Vector2
		
	direction.x = Input.get_action_strength(right) - Input.get_action_strength(left)
	direction.y = Input.get_action_strength(down) - Input.get_action_strength(up)
	
	if abs(direction.x) == 1 and abs(direction.y) == 1:
		direction = direction.normalized()
		
	movement = sens * direction * delta
	
	position += movement
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed(a):
		main.click(player_number, current_hover)

func _on_area_entered(area: Area2D) -> void:
	if not area.name.contains("Cursor"):
		current_hover = area

func _on_area_exited(area: Area2D) -> void:
	if area == current_hover:
		current_hover = null

extends CharacterBody2D


var speed = 300
var bullet_speed = 1200
var bullet = preload("res://Minigames/NeighborhoodWatch/Scenes/bullet.tscn")
var ammo = 6
var deadzone = 0.3
var controller_angle = Vector2.ZERO
var xAxisRL
var yAxisUD
var left = ""
var right = ""
var up = ""
var down = ""
var a = ""
var character = ""
var controller_number = -1
var hand_texture = [null, "res://Minigames/NeighborhoodWatch/Assets/Guns/gun1.png",\
"res://Minigames/NeighborhoodWatch/Assets/Guns/gun2.png",\
"res://Minigames/NeighborhoodWatch/Assets/Guns/gun3.png",\
"res://Minigames/NeighborhoodWatch/Assets/Guns/gun4.png"]
@onready var ammoLabel = $"../Ammo/AmmoLabel"

func _ready():
	if name.contains("1"):
		left = "left1"
		right = "right1"
		up = "up1"
		down = "down1"
		a = "rb1"
		controller_number = 0
		character = Global.playerchar[1]
		$Penguin.visible = false
		get_node(character).visible = true
		$Hand.texture = load(hand_texture[1])
	elif name.contains("2"):
		left = "left2"
		right = "right2"
		up = "up2"
		down = "down2"
		a = "rb2"
		controller_number = 1
		character = Global.playerchar[2]
		$Penguin.visible = false
		get_node(character).visible = true
		$Hand.texture = load(hand_texture[2])
	elif name.contains("3"):
		left = "left3"
		right = "right3"
		up = "up3"
		down = "down3"
		a = "rb3"
		controller_number = 2
		character = Global.playerchar[3]
		$Penguin.visible = false
		get_node(character).visible = true
		$Hand.texture = load(hand_texture[3])
	elif name.contains("4"):
		left = "left4"
		right = "right4"
		up = "up4"
		down = "down4"
		a = "rb4"
		controller_number = 3
		character = Global.playerchar[4]
		$Penguin.visible = false
		get_node(character).visible = true
		$Hand.texture = load(hand_texture[4])

func _physics_process(_delta):
	
	var input_direction: = Vector2(Input.get_action_strength(right) - \
	Input.get_action_strength(left), Input.get_action_strength(down) - \
	Input.get_action_strength(up))
		
	input_direction = input_direction.normalized()
	
	velocity = input_direction * speed
	move_and_slide()
	
	xAxisRL = Input.get_joy_axis(controller_number, JOY_AXIS_RIGHT_X)
	yAxisUD = Input.get_joy_axis(controller_number, JOY_AXIS_RIGHT_Y)
	if abs(xAxisRL) > deadzone || abs(yAxisUD) > deadzone:
		$Hand.rotation = Vector2(xAxisRL, yAxisUD).angle()
	
	if velocity.x > 0:
		get_node(character).flip_h = false
	elif velocity.x < 0:
		get_node(character).flip_h = true
	if Input.is_action_just_pressed(a) and ammo > 0:
		ammo = ammo - 1
		ammoLabel.text = str(ammo)
		fire()

func fire():
	$"../../../../Sounds/Gun".play()
	var bullet_instance = bullet.instantiate()
	bullet_instance.position = $Hand.get_global_position()
	bullet_instance.rotation_degrees = $Hand.rotation_degrees
	bullet_instance.apply_impulse(Vector2(bullet_speed, 0).\
	rotated($Hand.global_rotation), Vector2())
	match controller_number:
		0:
			$"../Enemies1".call_deferred("add_child", bullet_instance)
		1:
			$"../Enemies2".call_deferred("add_child", bullet_instance)
		2:
			$"../Enemies3".call_deferred("add_child", bullet_instance)
		3:
			$"../Enemies4".call_deferred("add_child", bullet_instance)

func kill():
	pass
	
func reload():
	ammo = 6
	ammoLabel.text = str(ammo)

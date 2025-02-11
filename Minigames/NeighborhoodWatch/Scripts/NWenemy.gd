extends CharacterBody2D

var speed = 3
var motion = Vector2()
var Player = null

func _ready():
	random_sprite()
	var par = get_parent()
	var grand = get_parent().get_parent()
	if par.get_name().contains("1"):
		Player = grand.get_node("PlayersCB1")
	elif par.get_name().contains("2"):
		Player = grand.get_node("PlayersCB2")
	elif par.get_name().contains("3"):
		Player = grand.get_node("PlayersCB3")
	elif par.get_name().contains("4"):
		Player = grand.get_node("PlayersCB4")

func _physics_process(_delta):
	if Player != null:
		motion += (Vector2(Player.position) - position)
	motion = motion.normalized() * speed
	move_and_collide(motion)
	if motion.x > 0:
		$AnimatedSprite2D.flip_h = false
	elif motion.x < 0:
		$AnimatedSprite2D.flip_h = true

func _on_hitbox_body_entered(body: Node2D) -> void:
	if body.get_collision_layer_value(2):
		$"../../../../../Sounds/Enemy".play()
		body.queue_free()
		queue_free()
	elif body.name.contains("CB1"):
		var tween = create_tween()
		tween.tween_property($"../../DeathRec", "color", Color("000000"), 0.2)
		$"../../../../..".player_dead(1)
		await get_tree().create_timer(0.3).timeout
		$"../../DeathRec/DeathLabel".visible = true
	elif body.name.contains("CB2"):
		var tween = create_tween()
		tween.tween_property($"../../DeathRec", "color", Color("000000"), 0.2)
		$"../../../../..".player_dead(2)
		await get_tree().create_timer(0.3).timeout
		$"../../DeathRec/DeathLabel".visible = true
	elif body.name.contains("CB3"):
		var tween = create_tween()
		tween.tween_property($"../../DeathRec", "color", Color("000000"), 0.2)
		$"../../../../..".player_dead(3)
		await get_tree().create_timer(0.3).timeout
		$"../../DeathRec/DeathLabel".visible = true
	elif body.name.contains("CB4"):
		var tween = create_tween()
		tween.tween_property($"../../DeathRec", "color", Color("000000"), 0.2)
		$"../../../../..".player_dead(4)
		await get_tree().create_timer(0.3).timeout
		$"../../DeathRec/DeathLabel".visible = true

func random_sprite():
	var random_num = randi_range(1,5)
	$AnimatedSprite2D.play(str(random_num))

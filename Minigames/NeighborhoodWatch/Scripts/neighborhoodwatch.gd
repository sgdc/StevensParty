extends Node2D

@onready var woman = [$Grid/SubViewCon1/SubViewport/Woman/Woman1,\
$Grid/SubViewCon1/SubViewport/Woman/Woman2,\
$Grid/SubViewCon2/SubViewport/Woman/Woman1,\
$Grid/SubViewCon2/SubViewport/Woman/Woman2,\
$Grid/SubViewCon3/SubViewport/Woman/Woman1,\
$Grid/SubViewCon3/SubViewport/Woman/Woman2,\
$Grid/SubViewCon4/SubViewport/Woman/Woman1,\
$Grid/SubViewCon4/SubViewport/Woman/Woman2]

var enemy = preload("res://Minigames/NeighborhoodWatch/Scenes/NWenemy.tscn")
var count = 0
var time = 2.5
var scores = [null, 0,0,0,0]
var next_score = 1
@onready var enemies1 = $Grid/SubViewCon1/SubViewport/Enemies1
@onready var enemies2 = $Grid/SubViewCon2/SubViewport/Enemies2
@onready var enemies3 = $Grid/SubViewCon3/SubViewport/Enemies3
@onready var enemies4 = $Grid/SubViewCon4/SubViewport/Enemies4

func _ready() -> void:
	$AP.play("start")
	
func next_enemy():
	if count == 3:
		count = 0
		spawn_woman()
	if time > 0.8:
		time -= 0.1
	spawn_enemy()
	count += 1
	await get_tree().create_timer(time).timeout
	next_enemy()

func _on_bullet_kill_body_entered(body: Node2D) -> void:
	body.queue_free()

func _on_woman_body_entered(body: Node2D) -> void:
	if body.name.contains("CB1"):
		body.reload()
		woman[0].visible = false
		woman[1].visible = false
		woman[0].set_deferred("monitoring", false)
		woman[1].set_deferred("monitoring", false)
	elif body.name.contains("CB2"):
		body.reload()
		woman[2].visible = false
		woman[3].visible = false
		woman[2].set_deferred("monitoring", false)
		woman[3].set_deferred("monitoring", false)
	elif body.name.contains("CB3"):
		body.reload()
		woman[4].visible = false
		woman[5].visible = false
		woman[4].set_deferred("monitoring", false)
		woman[5].set_deferred("monitoring", false)
	elif body.name.contains("CB4"):
		body.reload()
		woman[6].visible = false
		woman[7].visible = false
		woman[6].set_deferred("monitoring", false)
		woman[7].set_deferred("monitoring", false)
		
func spawn_woman():
	var onetwo = randi_range(1,2)
	var i = 0
	match onetwo:
		1:
			while i <= 7:
				if i % 2 == 0:
					woman[i].visible = true
					woman[i].set_deferred("monitoring", true)
				else:
					woman[i].visible = false
					woman[i].set_deferred("monitoring", false)
				i += 1
		2:
			while i <= 7:
				if i % 2 == 1:
					woman[i].visible = true
					woman[i].set_deferred("monitoring", true)
				else:
					woman[i].visible = false
					woman[i].set_deferred("monitoring", false)
				i += 1

func spawn_enemy():
	var enemyI1 = enemy.instantiate()
	enemies1.add_child(enemyI1)
	var enemyI2 = enemy.instantiate()
	enemies2.add_child(enemyI2)
	var enemyI3 = enemy.instantiate()
	enemies3.add_child(enemyI3)
	var enemyI4 = enemy.instantiate()
	enemies4.add_child(enemyI4)
	var rand_num = randi_range(1,4)
	match rand_num:
		1:
			enemyI1.global_position = enemies1.get_child(0).global_position
			enemyI2.global_position = enemies2.get_child(0).global_position
			enemyI3.global_position = enemies3.get_child(0).global_position
			enemyI4.global_position = enemies4.get_child(0).global_position
		2:
			enemyI1.global_position = enemies1.get_child(1).global_position
			enemyI2.global_position = enemies2.get_child(1).global_position
			enemyI3.global_position = enemies3.get_child(1).global_position
			enemyI4.global_position = enemies4.get_child(1).global_position
		3:
			enemyI1.global_position = enemies1.get_child(2).global_position
			enemyI2.global_position = enemies2.get_child(2).global_position
			enemyI3.global_position = enemies3.get_child(2).global_position
			enemyI4.global_position = enemies4.get_child(2).global_position
		4:
			enemyI1.global_position = enemies1.get_child(3).global_position
			enemyI2.global_position = enemies2.get_child(3).global_position
			enemyI3.global_position = enemies3.get_child(3).global_position
			enemyI4.global_position = enemies4.get_child(3).global_position

func player_dead(player_number):
	if scores.size() == 5 and scores[player_number] == 0:
		scores[player_number] = next_score
		next_score += 1
		if next_score == 4:
			await get_tree().create_timer(0.5).timeout
			end_game()

func end_game():
	scores[0] = -1
	scores.erase(-1)
	var f = 0
	while f <= 3:
		if scores[f] == 0:
			scores[f] = 4
		f += 1
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

extends Node

var current_scene = null

var firstplayer = 1
var lastplayer = 4
var playerturn = firstplayer

var playerchar = [null, "Penguin", "Hunter", "Watch", "Thief"]

var playercharnum = [null, 1, 2, 3, 4]

var playerpos = [null, Vector2(2033,495), Vector2(2119,485), \
					Vector2(2034,399), Vector2(2124,385)]
var playerspaces = [null, 13, 13, 13, 13]
var playerflipped = [null, false, false, false, false]

var playercoin = [null, 100,100,100,100]

var playerstar = [null, 0,0,0,0]

var playeritems = [null, [1,1,1], [1,1,1], [1,1,1], [1,1,1]]

var playerbonusroll = [null, 0, 0, 0, 0]
var playerbonusextra = [null, 0, 0, 0, 0]

var turn = 0
var lastturn = 15
var starspot = 0

var minigame_placements = [[],[],[],[]]

var blue = "0043ff"
var red = "871600"
var green = "006b13"
var yellow = "dcb10e"

func reset():
	playerpos = [null, Vector2(2033,495), Vector2(2119,485), \
					Vector2(2034,399), Vector2(2124,385)]
	playerspaces = [null, 13, 13, 13, 13]
	playerflipped = [null, false, false, false, false]
	playercoin = [null, 10,10,10,10]
	playerstar = [null, 0,0,0,0]
	playeritems = [null, [0,0,0], [0,0,0], [0,0,0], [0,0,0]]
	playerbonusroll = [null, 0, 0, 0, 0]
	playerbonusextra = [null, 0, 0, 0, 0]
	turn = 0
	lastturn = 15
	starspot = 0

func _ready():
	var root = get_tree().root
	current_scene = root.get_child(root.get_child_count()-1)

func switch_scene(res_path):
	call_deferred("_deferred_switch_scene",res_path)
	
func _deferred_switch_scene(res_path):
	current_scene.free()
	var s = load(res_path)
	current_scene = s.instantiate()
	get_tree().root.add_child(current_scene)
	get_tree().current_scene = current_scene

var icon = [null,\
"res://MiscAssets/Players/Icons/Penguin.png",\
"res://MiscAssets/Players/Icons/Hunter.png",\
"res://MiscAssets/Players/Icons/Watch.png",\
"res://MiscAssets/Players/Icons/Thief.png",\
"a",\
"b",\
"c",\
"d",\
"e",\
"f"]

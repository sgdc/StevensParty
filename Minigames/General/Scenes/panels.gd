extends Control

func _ready():
	$B.set_deferred("size", Vector2(480, 1080))
	$R.set_deferred("size", Vector2(480, 1080))
	$G.set_deferred("size", Vector2(480, 1080))
	$Y.set_deferred("size", Vector2(480, 1080))
	
	$B.set_deferred("position", Vector2(0, -1080))
	$R.set_deferred("position", Vector2(480, 1080))
	$G.set_deferred("position", Vector2(960, -1080))
	$Y.set_deferred("position", Vector2(1440, 1080))

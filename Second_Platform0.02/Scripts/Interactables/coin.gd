extends Node2D
#When a player gets them all they get a special trophy

func _ready():
	$AnimationPlayer.play("Idle")

func _on_area_2d_area_entered(area):
	if area.get_parent() is Player:
		GameManager.gain_coin(1)
		print(area)
		queue_free()

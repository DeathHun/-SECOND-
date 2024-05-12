extends Node2D

func _on_area_2d_area_entered(area):
	GameManager.gain_coin(1)
	queue_free()

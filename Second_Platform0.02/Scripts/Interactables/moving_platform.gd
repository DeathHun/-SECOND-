extends Node2D

var moving = false

func _on_area_2d_area_entered(area):
	if area.get_parent() is Player && !moving:
		moving = true
		$AnimationPlayer.play("Move")

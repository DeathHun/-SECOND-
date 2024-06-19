extends Node2D

var entered = false

func _on_area_2d_area_entered(area):
	if area.get_parent() is Player && !entered:
		$AnimationPlayer.play("Fade In")
		entered = true

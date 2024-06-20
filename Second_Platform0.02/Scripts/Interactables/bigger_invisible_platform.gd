extends StaticBody2D
#This object detects whenever a player is near it and only then reveals itself

var showing = false

func _on_area_2d_area_entered(area):
	if area.get_parent() is Player && !showing:
		showing = true
		$AnimationPlayer.play("Fade In")


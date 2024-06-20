extends Node2D



func _ready():
	$AnimationPlayer.play("Idle")

func _on_area_2d_area_entered(area):
	if area.get_parent() is Player:
		GameManager.key_obtained = true
		$AnimationPlayer.play("Fade_Out")

extends Node2D
#Is one of the three collectable trophies in the game, and requires a key to be oppened

func _on_area_2d_area_entered(area):
	if area.get_parent() is Player && GameManager.key_obtained == true:
		GameManager.chest_oppened = true
		GameManager.coins += 5
		$AnimationPlayer.play("Unlocked")
		await get_tree().create_timer(0.7).timeout 
		$AnimationPlayer.play("Fade_Out")

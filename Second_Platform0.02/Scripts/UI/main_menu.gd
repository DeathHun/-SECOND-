extends Control

func _on_quit_pressed():
	GameManager.quit()

func _on_start_pressed():
	get_tree().change_scene_to_file("res://Scenes/WorldScene/MainLevel.tscn")

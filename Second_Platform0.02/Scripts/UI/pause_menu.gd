extends Control

func _ready():
	GameManager.pause_menu = $"."

func _on_resume_pressed():
	GameManager.resume()

func _on_restart_pressed():
	GameManager.restart()

func _on_map_pressed():
	GameManager.load_world()

func _on_quit_pressed():
	GameManager.quit()

func _process(delta):
	if Input.is_action_just_pressed("pause"):
		GameManager.pause_play()

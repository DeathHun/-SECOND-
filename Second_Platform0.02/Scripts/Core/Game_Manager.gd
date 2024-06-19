extends Node

signal gained_coins(int)

var coins : int = 0
var current_checkpoint : Checkpoint
var player : Player

var paused = false
var pause_menu
var win_screen

func respawn_player():
	player.health = player.max_health
	if current_checkpoint != null:
		player.position = current_checkpoint.global_position

func gain_coin(coins_gained : int):
	coins += coins_gained
	emit_signal("gained_coins", coins_gained)

func win():
	win_screen.visible = true

func pause_play():
	paused = !paused
	
	pause_menu.visible = paused

func resume():
	pause_play()

func restart():
	coins = 0
	current_checkpoint = null
	get_tree().reload_current_scene()

func load_world():
	get_tree().change_scene_to_file("res://Scenes/WorldScene/level_two.tscn")

func quit():
	get_tree().quit()

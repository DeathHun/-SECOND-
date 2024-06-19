extends Node

signal gained_coins(int)

var coins : int = 0
var current_checkpoint : Checkpoint
var player : Player

var paused = false
var pause_menu

func respawn_player():
	player.health = player.max_health
	if current_checkpoint != null:
		player.position = current_checkpoint.global_position

func gain_coin(coins_gained : int):
	coins += coins_gained
	emit_signal("gained_coins", coins_gained)

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
	pass

func quit():
	get_tree().quit()

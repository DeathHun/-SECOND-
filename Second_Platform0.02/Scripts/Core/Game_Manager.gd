extends Node

signal gained_coins(int)

var coins : int = 0
var health: int = 0
var current_checkpoint : Checkpoint
var player : Player

var paused = false
var pause_menu
var win_screen

var key_obtained = false
var chest_oppened = false
var enemies_defeated:int

var stop_timer = false

#This function is called when the player's health is 0
func respawn_player():
	player.health = player.max_health
	if current_checkpoint != null:
		player.position = current_checkpoint.global_position

#This function is called when a player enters a coins "area 2d"
func gain_coin(coins_gained : int):
	coins += coins_gained
	emit_signal("gained_coins", coins_gained)

#This function is called when the player arives at the last checkpoint
func win():
	win_screen.visible = true
	stop_timer = true

#This function is called when the pause buttons are pressed in any GUI
func pause_play():
	paused = !paused
	
	pause_menu.visible = paused

#This function is called when any button that resumes is pressed
func resume():
	pause_play()

#This function is called when any button that restarts is pressed
func restart():
	coins = 0
	enemies_defeated = 0
	chest_oppened = false
	key_obtained = false
	current_checkpoint = null
	get_tree().reload_current_scene()

#This function is called in the main menu to open the actual level
func load_world():
	get_tree().change_scene_to_file("res://Scenes/WorldScene/MainLevel.tscn")

#This function is called when any quit button is pressed
func quit():
	get_tree().quit()

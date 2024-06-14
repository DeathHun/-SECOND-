extends Node2D

@export var speed = 160.0
var current_speed = 0.0

func _physics_process(delta):
	position.y += current_speed * delta

func _on_hitbox_area_entered(area):
	if area.get_parent() is Player:
		area.get_parent().death()

func _on_playerdetect_area_entered(area):
	if area.get_parent() is Player:
		$AnimationPlayer.play("Shake")

func fall():
	current_speed = speed

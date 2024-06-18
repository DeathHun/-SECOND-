extends Node2D

@export var speed = 230.0
@export var spawn_pos = global_position

var current_speed = 0.0

func _physics_process(delta):
	position.y += current_speed * delta

func _on_hitbox_area_entered(area):
	if area.get_parent() is Player:
		area.get_parent().take_damage(1)
		queue_free()

func _on_playerdetect_area_entered(area):
	if area.get_parent() is Player:
		$AnimationPlayer.play("Shake")

func fall():
	current_speed = speed
	await get_tree().create_timer(1.1).timeout
	position = spawn_pos
	current_speed = 0
	queue_free()
	

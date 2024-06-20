extends StaticBody2D
#An enemy type

var canon_ball = load("res://Scenes/Interactables/canon_ball.tscn")
var debris = load("res://Scenes/Interactables/cannon_debris.tscn")

@export var shooting : bool
var firerate = 2

@onready var animation_player = $AnimationPlayer
@onready var firepoint = $Firepoint

var max_health = 3
var health 


func _ready():
	health = max_health
	shooting = true
	shoot()

func shoot():
	while shooting:
		animation_player.play("Fire")
		await get_tree().create_timer(firerate).timeout

func fire():
		var spawn_ball = canon_ball.instantiate()
		spawn_ball.direction = firepoint.scale.x 
		spawn_ball.global_position = firepoint.position
		add_child(spawn_ball)

func take_damage(damage_taken):
	health -= damage_taken
	
	get_node('HealthBar').update_healthbar(health, max_health)
	
	animation_player.play("Hit")
	if health <= 0:
		death()

func death():
	var spawned_debris = debris.instantiate()
	spawned_debris.global_position = position
	spawned_debris.scale.x = scale.x
	spawned_debris.get_child(1).play("Crumble")
	get_tree().get_root().get_child(1).add_child(spawned_debris)
	GameManager.enemies_defeated += 1
	queue_free()


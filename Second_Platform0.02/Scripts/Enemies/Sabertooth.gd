extends CharacterBody2D

var speed = -60
var current_speed = 0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var facing_right =  false
var dead = false

var health 
var max_health = 2 
var hit = false
var can_attack = true

#This function is called whenever this scene first runs
func _ready():
	health = max_health
	$AnimationPlayer.play("Run")

#This function is called every seconds while the scene is running
func _physics_process(delta):
	
	apply_grav(delta)
	
	if !$RayCast2D.is_colliding() and is_on_floor():
		flip()
	if $RayCast2D2.is_colliding() and is_on_floor():
		flip() 
	
	
	movement()
	
	move_and_slide()

#This function controles how fast the enemy walks
func movement():
	velocity.x = speed

#This function applies gravity
func apply_grav(delta):
	if not is_on_floor():
		velocity.y += gravity * delta

#This function is called to change the direction of the sprite of the enemy
func flip():
	facing_right = !facing_right
	
	scale.x = abs(scale.x) * -1
	if facing_right:
		speed = abs(speed)
	else:
		speed = abs(speed) * -1

#This function is called whenever the players enters it's "area_2d"
func _on_hitbox_area_entered(area):
	if area.get_parent() is Player && !dead && can_attack:
		area.get_parent().take_damage(1)

#This function is used to kill and remove the enemy from the scenes
func death():
	dead = true
	speed=0
	$AnimationPlayer.play("Dead")
	#This animation has an inbuilt method called "queue_free()" which just removes the enemy from the main scene

#This function is called when the player's "area_2d" interacts with this enemy
func take_damage(damage_taken: int):
	if !dead:
		$AnimationPlayer.play("Hit")
		
		health -= damage_taken
		
		get_node('HealthBar').update_healthbar(health, max_health)
		
		if health <= 0:
			death()
			GameManager.enemies_defeated += 1

#This function is called when the player's "area_2d" interacts with this enemy
func get_hit():
	hit = !hit
	
	if hit:
		current_speed = speed
		speed = 0
		can_attack = false
		
	else:
		speed = current_speed
		can_attack = true
		$AnimationPlayer.play('Run')



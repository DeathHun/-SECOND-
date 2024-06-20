extends CharacterBody2D
#Copied exactly from the sabertooth enemy except for some small differences like health


var speed = -60
var current_speed = 0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var facing_right =  false
var dead = false

var health 
var max_health = 4 
var hit = false
var can_attack = true

func _ready():
	health = max_health
	$AnimationPlayer.play("Run")

func _physics_process(delta):
	
	apply_grav(delta)
	
	if !$RayCast2D.is_colliding() and is_on_floor():
		flip()
	if $RayCast2D2.is_colliding() and is_on_floor():
		flip() 
	
	
	movement()
	
	move_and_slide()


func movement():
	velocity.x = speed

func apply_grav(delta):
	if not is_on_floor():
		velocity.y += gravity * delta

func flip():
	facing_right = !facing_right
	
	scale.x = abs(scale.x) * -1
	if facing_right:
		speed = abs(speed)
	else:
		speed = abs(speed) * -1


func _on_hit_box_area_entered(area):
	if area.get_parent() is Player && !dead && can_attack:
		area.get_parent().take_damage(1)

func death():
	dead = true
	speed=0
	$AnimationPlayer.play("Dead")

func take_damage(damage_taken: int):
	if !dead:
		$AnimationPlayer.play("Hit")
		
		health -= damage_taken
		
		get_node('HealthBar').update_healthbar(health, max_health)
		
		if health <= 0:
			death()
			GameManager.enemies_defeated += 1

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








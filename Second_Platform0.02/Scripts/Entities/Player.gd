extends CharacterBody2D
class_name Player

@onready var animation : AnimationPlayer = $AnimationPlayer
@onready var sprite :Sprite2D = $Sprite2D
@onready var coyote_timer = $CoyoteTimer

@export var attacking = false
@export var speed  = 200.0
@export var jump_velocity = -400.0
@export var friction = 3000
@export var air_resistance = 3000
@export var Coyote_Time : float = 0.2

var has_timer_start : bool = false
var air_jump : bool = false
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var wall_jump : bool = false
var wall_normal : Vector2
var jump_available : bool = true

#heatlh bar
var max_health = 5
var health = 0
var can_take_damage = true
@export var hit = false 

#This function is called whenever the scene first opens
func _ready():
	health = max_health
	GameManager.player = self

#This function is called every second
func _process(delta):
	if Input.is_action_just_pressed("attack") && !hit:
		attack()
	GameManager.health = health 

#This function is called every second
func _physics_process(delta):
	
	if Input.is_action_pressed("down") && is_on_floor():
		position.y += 5
	
	
	add_gravity(delta)
	jump_action()
	movement(delta)
	handle_wall_jump()
	update_animation()

	move_and_slide()
	
	if position.y > 900:
		death()
	

#This function adds gravity
func add_gravity(delta):
	if not is_on_floor():
		velocity.y += 1.25 * gravity * delta

#This function gets the user's input and travels in the respective direction and also controls forces like friction and air resistance
func movement(delta):
	var direction = Input.get_axis("left", "right")
	if direction != 0:
		velocity.x = speed*direction

	else:
		if not is_on_floor():
			velocity.x = move_toward(velocity.x, 0, delta*air_resistance)

		else:
			velocity.x = move_toward(velocity.x, 0, delta*friction)

#This function controls the player's jumping movement which a coyote_timer which is a period after the player leaves a floor and is able to jump before the timer ends
func jump_action():
	if is_on_floor():
		air_jump = false
		jump_available = true
		coyote_timer.stop()
	
	if not is_on_floor():
		if jump_available:
			if coyote_timer.is_stopped():
				air_jump = true
				coyote_timer.start(Coyote_Time)
			

	
	if Input.is_action_just_pressed("jump") and jump_available:
			velocity.y = jump_velocity
			air_jump = true
			jump_available = false
	
	elif Input.is_action_just_pressed("jump") and air_jump == true:
		velocity.y = jump_velocity
		air_jump = false

func Coyote_Timeout():
	jump_available = false

#This function is called when on a wall
func handle_wall_jump():
	if not is_on_wall(): return
	if is_on_wall_only() and Input.is_action_just_pressed("right"):
		wall_normal = get_wall_normal()
		velocity.x = wall_normal.x * speed 
		velocity.y = jump_velocity

	if is_on_wall_only() and Input.is_action_just_pressed("left"):
		wall_normal = get_wall_normal()
		velocity.x = wall_normal.x * speed 
		velocity.y = jump_velocity

#This function controls the player's animations
func update_animation():
	if !attacking && !hit:
		if velocity.x < 0:
			sprite.scale.x = abs(sprite.scale.x) * -1
			$Area2D.scale.x = abs($Area2D.scale.x) * -1
			$AttackArea.scale.x = abs($AttackArea.scale.x) * -1
		if velocity.x > 0:
			sprite.scale.x = abs(sprite.scale.x)
			$Area2D.scale.x = abs($Area2D.scale.x)
			$AttackArea.scale.x = abs($AttackArea.scale.x) 
		
		
		
		if velocity.x != 0 and is_on_floor():
			animation.play("Run")
		if velocity.x == 0 and is_on_floor():
			animation.play("Idle")
		if velocity.y < 0 and not is_on_floor():
			animation.play("Jump")
		if velocity.y > 0 and not is_on_floor():
			animation.play("Fall")

#This function is called when it interacts with any enemies 
func take_damage(damage_amount: int):
	if can_take_damage:
		iframes()
		
		hit = true
		attacking = false
		animation.play('Hit')
		
		health -= damage_amount
		
		if health <= 0:
			death()

#This function creates a time frame where the player is immune for a short period
func  iframes():
	can_take_damage = false
	await get_tree().create_timer(1).timeout
	can_take_damage = true

#This function just calles a method from a global script which allows the player to respawn
func death():
	GameManager.respawn_player()

#This function is called when the player left clicks on the mouse and will attack an enemy
func attack():
	var overlapping_objects = $AttackArea.get_overlapping_areas()
	
	for area in overlapping_objects:
		if area.get_parent().is_in_group("Enemies"):
			area.get_parent().take_damage(1)
	
	attacking = true
	animation.play("Attack")

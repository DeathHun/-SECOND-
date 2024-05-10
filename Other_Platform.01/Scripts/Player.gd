extends CharacterBody2D

@onready var animation : AnimationPlayer = $AnimationPlayer
@onready var sprite :Sprite2D = $Sprite2D


@export var speed  = 280.0
@export var jump_velocity = -400.0
@export var friction = 800
@export var air_resistance = 300

var air_jump : bool = false
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var wall_jump : bool = false
var wall_normal : Vector2

func _physics_process(delta):
	
	add_gravity(delta)
	jump_action()
	movement(delta)
	handle_wall_jump()
	handle_wall_slide()
	update_animation()
	
	move_and_slide()

func add_gravity(delta):
	if not is_on_floor():
		velocity.y += 1.25 * gravity * delta

func movement(delta):
	var direction = Input.get_axis("left", "right")
	if direction != 0:
		velocity.x = direction * speed
		handle_wall_slide()
	else:
		if not is_on_floor():
			velocity.x = move_toward(velocity.x, 0, delta*air_resistance)
			handle_wall_slide()
		else:
			velocity.x = move_toward(velocity.x, 0, delta*friction)
			handle_wall_slide()

func jump_action():
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity
		air_jump = true

	elif Input.is_action_just_pressed("jump") and air_jump == true:
		velocity.y = jump_velocity
		air_jump = false


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


func handle_wall_slide():
	if is_on_wall_only() and velocity.y > 0:
		velocity.y += -8
		print(velocity.y)

func update_animation():
	if Input.is_action_just_pressed("left"):
		sprite.scale.x = abs(sprite.scale.x) * -1
	if Input.is_action_just_pressed("right"):
		sprite.scale.x = abs(sprite.scale.x)
	if velocity.x != 0 and is_on_floor():
		animation.play("Run")
	if velocity.x == 0 and is_on_floor():
		animation.play("Idle")
	if velocity.y < 0 and not is_on_floor():
		animation.play("Jump")
	if velocity.y > 0 and not is_on_floor():
		animation.play("Fall")

func crouch():
	pass


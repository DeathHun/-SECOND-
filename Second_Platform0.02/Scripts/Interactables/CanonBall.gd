extends Node2D
#The balls that come out whenever the canon shoots

var direction
var speed = 200.0
var life_time = 2.0
var hit = false

func _ready():
	await get_tree().create_timer(life_time).timeout
	death()

func _physics_process(delta):
	position.x += abs(speed * delta) * direction 

func death():
	hit = true
	speed = 0
	$AnimationPlayer.play("Hit")

func _on_area_2d_area_entered(area):
	if area.get_parent() is Player && !hit:
		area.get_parent().take_damage(1)
		death()

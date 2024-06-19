extends Control

var fill_amount : float

func _ready():
	$ProgressBar.value = 100

func update_healthbar(health, max_health):
	fill_amount = (float(health) / max_health) * 100
	$ProgressBar.value = fill_amount


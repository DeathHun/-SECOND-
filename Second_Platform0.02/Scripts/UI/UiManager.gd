extends CanvasLayer

var time: float = 0.0
var minutes: int = 0
var seconds: int = 0
var msec: int = 0

func _ready():
	GameManager.gained_coins.connect(update_coin_display)

func update_coin_display(_gained_coins):
	$CoinDisplay.text = str(GameManager.coins)

func _process(delta) -> void:
	$HeartDisplay.text = str(GameManager.health)
	$EnemyDisplay.text = str(GameManager.enemies_defeated)
	time += delta
	msec = fmod(time, 1) * 100
	seconds = fmod(time, 60) 
	minutes = fmod(time, 3600) / 60
	$Panel/Minutes.text = "%02d:" % minutes
	$Panel/Seconds.text = "%02d." % seconds
	$Panel/MSeconds.text = "%03d" % msec
	
	if GameManager.stop_timer == true:
		set_process(false)





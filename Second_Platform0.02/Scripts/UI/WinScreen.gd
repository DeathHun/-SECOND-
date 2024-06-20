extends Label

func _process(delta):
	if GameManager.chest_oppened == true:
		$Treasure.visible = true
	if GameManager.coins >= 20:
		$Coins.visible = true
	if GameManager.enemies_defeated >=5:
		$Skulls.visible = true

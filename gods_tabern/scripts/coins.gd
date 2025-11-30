extends CanvasLayer


func _process(delta):
	$CoinsCollected.text = str(Globals.coins)

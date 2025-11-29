extends CanvasLayer

var coins = 0
@onready var coinsCollected: Label = $CoinsCollected

func coins_collected():
	coins += 1
	coinsCollected.text = str(coins)
	
func timeStopCost():
		coins -= 10
		coinsCollected.text = str(coins)

extends CanvasLayer

func _process(delta):
	$Lives.text = str(Globals.vidas)

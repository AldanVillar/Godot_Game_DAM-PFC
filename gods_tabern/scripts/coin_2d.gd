extends Area2D


func _ready() -> void:
	$AnimatedSprite2D.play("idle")
	
func _on_body_entered(body: Node2D) -> void:
	if body.name == "MainCh":
		$"../Coin".play()
		$"../../../MainCh/HUD/coins".coins_collected()
		queue_free()

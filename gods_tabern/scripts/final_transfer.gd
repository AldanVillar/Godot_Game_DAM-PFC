extends Area2D




func _on_body_entered(body: Node2D) -> void:
	if body.name == "MainCh":
		body.velocity.x = 0
		body.velocity.y = 0
		$CollisionShape2D.queue_free()
		$Timer.start()
		await($Timer.timeout)
		get_tree().change_scene_to_file("res://scenes/ultimo_nivel.tscn")

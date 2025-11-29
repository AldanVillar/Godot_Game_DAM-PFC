extends CharacterBody2D

const SPEED = 60

func _ready():
	velocity.x = SPEED
	$AnimatedSprite2D.play("run")

func _physics_process(delta):
	if is_on_wall():
		if $AnimatedSprite2D.flip_h:
			velocity.x = -SPEED
		else:
			velocity.x = SPEED
				
	if velocity.x > 0:
		$AnimatedSprite2D.flip_h = true
	elif velocity.x < 0:
		$AnimatedSprite2D.flip_h = false

	move_and_slide()
	
func _parryDmg():
	velocity.x = 0
	velocity.y = 0
	$AnimatedSprite2D.play("death")
	$Area2D/CollisionShape2D.queue_free()
	$CollisionShape2D.queue_free()
	await($AnimatedSprite2D.animation_finished)
	queue_free()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "MainCh":
		body._damage()
		velocity.x = 0
		velocity.y = 0
		$AnimatedSprite2D.play("atq")
		await($AnimatedSprite2D.animation_finished)
		$AnimatedSprite2D.play("run")
		if $AnimatedSprite2D.flip_h:
			velocity.x = SPEED
		else:
			velocity.x = -SPEED
		


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.name == "atq" or area.name == "contraatq":
		velocity.x = 0
		velocity.y = 0
		$AnimatedSprite2D.play("death")
		$Area2D/CollisionShape2D.queue_free()
		$CollisionShape2D.queue_free()
		await($AnimatedSprite2D.animation_finished)
		queue_free()

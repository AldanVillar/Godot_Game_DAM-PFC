extends CharacterBody2D

const SPEED = 50
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var vida = 5

func _ready():
	velocity.x = SPEED
	$AnimatedSprite2D.play("run")

func _physics_process(delta):
	if is_on_wall():
		if $AnimatedSprite2D.flip_h:
			velocity.x = -SPEED
		else:
			velocity.x = SPEED
	
	# --- NUEVO: detección de borde con RayCast2D ---
	if not $RayCastSuelo.is_colliding():
		velocity.x = -velocity.x

	if velocity.x > 0:
		$AnimatedSprite2D.flip_h = true
	elif velocity.x < 0:
		$AnimatedSprite2D.flip_h = false

	if not is_on_floor():
		velocity.y += gravity * delta
				
	move_and_slide()


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.name == "atq" or area.name == "contraatq":
		if  area.name == "atq":
			vida -= 1
		if  area.name == "contraatq":
			vida -= 3
		if vida <= 0:
			velocity.x = 0
			velocity.y = 0
			gravity = 0
			$AnimatedSprite2D.play("damage")
			$Area2D/CollisionShape2D.queue_free()
			$CollisionShape2D.queue_free()
			await($AnimatedSprite2D.animation_finished)
			queue_free()
		else:
			velocity.x = 0
			$AnimatedSprite2D.play("damage")
			await($AnimatedSprite2D.animation_finished)
			$AnimatedSprite2D.play("run")
			if $AnimatedSprite2D.flip_h:
				velocity.x = -SPEED
			else:
				velocity.x = SPEED


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "MainCh":
		body._damage()

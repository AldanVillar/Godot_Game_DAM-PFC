extends CharacterBody2D

const SPEED = 100
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

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

	if not is_on_floor():
		velocity.y += gravity * delta
			
	move_and_slide()
		
func _on_area_2d_body_entered(CharacterBody2D):
	if CharacterBody2D.name == "Main_Ch":
		$"../../Main_Ch"._damage()
		
func _on_area_2d_area_entered(area: Area2D) -> void:
	velocity.x = 0
	velocity.y = 0
	$AnimatedSprite2D.play("death")
	$Area2D/CollisionShape2D.queue_free()
	$CollisionShape2D.queue_free()
	await($AnimatedSprite2D.animation_finished)
	queue_free()

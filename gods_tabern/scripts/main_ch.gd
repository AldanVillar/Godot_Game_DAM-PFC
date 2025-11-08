extends CharacterBody2D


const SPEED = 250.0
const JUMP_VELOCITY = -400.0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var is_facing_right = true
var vidas = 10
var damage = false
var atq = false

@onready var animated_sprite = $AnimatedSprite2D
@onready var animated_atq = $"atq/AnimatedSprite2D"
	
func _physics_process(delta: float) -> void:
	jump(delta)
	move_x()
	flip()
	update_movement_animations()

func jump(delta):
	if atq == false and damage == false:
		if Input.is_action_just_pressed("ui_accept") and is_on_floor():
			velocity.y = JUMP_VELOCITY
		
		if not is_on_floor():
			velocity.y += gravity * delta

func move_x():
	if atq == false and damage == false:
		var direction := Input.get_axis("ui_left", "ui_right")
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
		
func flip():
	if atq == false and damage == false:
		if (is_facing_right and velocity.x < 0) or (not is_facing_right and velocity.x > 0):
			scale.x *= -1
			is_facing_right = not is_facing_right
			
func update_movement_animations():
	if atq == false and damage == false:
		if not is_on_floor():
			if velocity.y < 0:
				animated_sprite.play("jump")
			else:
				animated_sprite.play("fall")
		else:
			if scale.x == 1:
				if velocity.x > 0:
					animated_sprite.play("walk")
				elif velocity.x < 0:
					animated_sprite.play("walk reverse")
				else:
					animated_sprite.play("idle")
			else:
				if velocity.x > 0:
					animated_sprite.play("walk reverse")
				elif velocity.x < 0:
					animated_sprite.play("walk")
				else:
					animated_sprite.play("idle")
				
func _damage():
	vidas -= 1
	damage = true
	animated_sprite.play("damage")
	await (animated_sprite.animation_finished)
	damage = false

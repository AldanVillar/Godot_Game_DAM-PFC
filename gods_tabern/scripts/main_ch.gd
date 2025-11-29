extends CharacterBody2D


const SPEED = 200.0
const JUMP_VELOCITY = -320.0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var is_facing_right = true
var vidas = 10
var damage = false
var atq = false
var block = false
var dead = false

@onready var animated_sprite = $AnimatedSprite2D

func _ready():
	$"atq/CollisionShape2D".disabled = true
	$parry/CollisionShape2D.disabled = true
	$contraatq/CollisionShape2D.disabled = true
	
func _physics_process(delta: float) -> void:
	jump(delta)
	move_x()
	flip()
	_atq()
	_block()
	update_movement_animations()
	move_and_slide()
	
func jump(delta):
	if atq == false and block == false and damage == false and dead == false:
		if Input.is_action_just_pressed("ui_accept") and is_on_floor():
			velocity.y = JUMP_VELOCITY
		
		if not is_on_floor():
			velocity.y += gravity * delta

func move_x():
	if atq == false and block == false and damage == false and dead == false:
		var direction := Input.get_axis("ui_left", "ui_right")
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
		
func flip():
	if atq == false and block == false and damage == false and dead == false:
		if (is_facing_right and velocity.x < 0) or (not is_facing_right and velocity.x > 0):
			scale.x *= -1
			is_facing_right = not is_facing_right


func update_movement_animations():
	if atq == false and block == false and damage == false and dead == false:
		if not is_on_floor():
			if velocity.y < 0:
				animated_sprite.play("jump")
			else:
				animated_sprite.play("fall")
		else:
			if velocity.x > 0:
				animated_sprite.play("walk")
			elif velocity.x < 0:
				animated_sprite.play("walk")
			else:
				animated_sprite.play("idle")
				
func _atq():
	if atq == false and damage == false and block == false and dead == false:
		if Input.is_action_just_pressed("atq") and velocity.y == 0:
			atq = true
			$"atq/CollisionShape2D".disabled = false
			velocity.y = 0
			velocity.x = 0
			animated_sprite.play("atq")
			await (animated_sprite.animation_finished)
			$"atq/CollisionShape2D".disabled = true
			atq = false

func _block():
	if atq == false and damage == false and block == false and dead == false:
		if Input.is_action_just_pressed("block") and velocity.y == 0:
			block = true
			$CollisionShape2D.disabled = true
			$parry/CollisionShape2D.disabled = false
			velocity.y = 0
			velocity.x = 0
			animated_sprite.play("block")
			await (animated_sprite.animation_finished)
			block = false
			$CollisionShape2D.disabled = false
			$parry/CollisionShape2D.disabled = true
			
func parry():
	print()
				
func _damage():
	vidas -= 1
	$HUD/life.update_damage()
	if vidas == 0:
		_death()
	else:
		damage = true
		velocity.x = 0
		animated_sprite.play("damage")
		await (animated_sprite.animation_finished)
		damage = false
	
func _death():
	dead = true
	velocity.x = 0
	velocity.y = 0
	$atq.queue_free()
	$CollisionShape2D.queue_free()
	animated_sprite.play("death")
	await(animated_sprite.animation_finished)
	get_tree().change_scene_to_file("res://scenes/menu_death.tscn")
	dead = false
	
func _voidDeath():
	get_tree().change_scene_to_file("res://scenes/menu_death.tscn")


func _on_parry_area_entered(area: Area2D) -> void:
	$contraatq/CollisionShape2D.disabled = false
	animated_sprite.play("contraatq")
	await (animated_sprite.animation_finished)
	$contraatq/CollisionShape2D.disabled = true


func _on_contraatq_body_entered(body: Node2D) -> void:
	body._parryDmg()

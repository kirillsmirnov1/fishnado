class_name Player extends CharacterBody2D

@export var horizontal_move_speed: float = 100
@export var jump_velocity: float = 100

@export var sprite: AnimatedSprite2D
@export var rod_wrap: Node2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _process(delta):
	base_movement(delta)
	handle_sprite()
	rotate_rod()
	move_and_slide()

func rotate_rod():
	rod_wrap.look_at(get_global_mouse_position())
	

func handle_sprite():
	if velocity.x > 0.0:
		sprite.flip_h = true
	elif velocity.x < 0.0:
		sprite.flip_h = false	
	
	var should_play = absf(velocity.x) > 0.0 and is_on_floor()
	if should_play and not sprite.is_playing():
		sprite.play()
	elif not should_play and sprite.is_playing():
		sprite.stop()
	

func base_movement(delta):
	var horizontal_input: float = Input.get_axis("left", "right")
	velocity.x = horizontal_input * horizontal_move_speed
	
	if(is_on_floor() and Input.is_action_just_pressed("up")):
		velocity.y = -jump_velocity
	
	if not is_on_floor():
		velocity.y += gravity * delta

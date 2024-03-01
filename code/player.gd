class_name Player extends CharacterBody2D

@export var horizontal_move_speed: float = 100
@export var jump_velocity: float = 100

@export var sprite: AnimatedSprite2D
@export var rod_wrap: Node2D
@export var rod_line: Line2D
@export var rod_raycast: RayCast2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var rod_line_connected: bool = false
var line_collision_point: Vector2

func _ready():
	rod_line.visible = false 

func _process(delta):
	handle_mouse_input()
	if rod_line_connected:
		rod_line_movement(delta)
	else:
		base_movement(delta)
		
	handle_sprite()
	rotate_rod()
	move_and_slide()

func handle_mouse_input():
	var mouse_pos = get_global_mouse_position()
	
	if Input.is_action_just_pressed("action"):
		rod_raycast.target_position = rod_raycast.to_local(mouse_pos) * 100 # 100 is to shoot further
		rod_raycast.force_raycast_update()
		if rod_raycast.is_colliding():
			rod_line_connected = true
			line_collision_point = rod_raycast.get_collision_point()
		
	elif Input.is_action_just_released("action"):
		rod_line_connected = false
	
	if rod_line_connected:
		rod_line.visible = true
		rod_line.points[1] = rod_line.to_local(line_collision_point)
	else:
		rod_line.visible = false
		
		
func rotate_rod():
	if rod_line_connected:
		rod_wrap.look_at(line_collision_point)
	else:
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
	
func rod_line_movement(delta):
	velocity = Vector2.ZERO
	pass


func base_movement(delta):
	var horizontal_input: float = Input.get_axis("left", "right")
	velocity.x = horizontal_input * horizontal_move_speed
	
	if(is_on_floor() and Input.is_action_just_pressed("up")):
		velocity.y = -jump_velocity
	
	if not is_on_floor():
		velocity.y += gravity * delta

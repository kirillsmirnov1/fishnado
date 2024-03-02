class_name Player extends CharacterBody2D

signal fell_down

@export var horizontal_move_speed: float = 100
@export var jump_velocity: float = 100

@export var angular_acceleration_k: float = 0.05
@export var angular_speed: float = 0.6
@export var line_length_change_speed: float = 100.0
@export var angular_damping: float = 0.995

@export var sprite: AnimatedSprite2D
@export var rod_wrap: Node2D
@export var rod_line: Line2D
@export var rod_raycast: RayCast2D
@export var line_length_offset: float = 20

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var rod_line_connected: bool = false
var line_collision_point: Vector2
var line_length: float
var line_angle: float
var angular_velocity = 0.0
var angular_acceleration = 0.0

func _ready():
	rod_line.visible = false 

func _process(delta):
	handle_mouse_input()
	
	handle_jump()
	if rod_line_connected:
		rod_line_movement(delta)
	else:
		base_movement(delta)
	move_and_slide()
	
	handle_sprite()
	rotate_rod()
	check_fall_death()
	

func handle_mouse_input():
	var mouse_pos = get_global_mouse_position()
	
	if Input.is_action_just_pressed("action"):
		rod_raycast.target_position = rod_raycast.to_local(mouse_pos) * 100 # 100 is to shoot further
		rod_raycast.force_raycast_update()
		if rod_raycast.is_colliding():
			init_rod_line_connection()
		
	elif Input.is_action_just_released("action"):
		rod_line_connected = false
	
	if rod_line_connected:
		rod_line.visible = true
		rod_line.points[1] = rod_line.to_local(line_collision_point)
	else:
		rod_line.visible = false
		

func init_rod_line_connection():
	line_collision_point = rod_raycast.get_collision_point()
	if line_collision_point.y > global_position.y:
		return
	rod_line_connected = true
	line_length = (line_collision_point - rod_wrap.global_position).length() - line_length_offset
	line_angle = Vector2.ZERO.angle_to(rod_wrap.global_position-line_collision_point) #- deg_to_rad(-90)
	angular_velocity = 0.0
	angular_acceleration = 0.0


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
	var horizontal_input: float = Input.get_axis("left", "right")
	var vertical_input: float = Input.get_axis("up", "down")
	
	line_length += vertical_input * line_length_change_speed * delta
	
	angular_velocity += horizontal_input * delta * angular_speed
	
	var angular_acceleration = ((-gravity * delta) / line_length) * sin(line_angle)	
	angular_velocity += angular_acceleration * angular_acceleration_k
	angular_velocity *= angular_damping
	line_angle += angular_velocity
	
	var target_pos = line_collision_point + \
			Vector2(line_length*sin(line_angle), line_length*cos(line_angle))
	
	velocity = (target_pos - global_position) * 5


func base_movement(delta):
	var horizontal_input: float = Input.get_axis("left", "right")
	velocity.x = horizontal_input * horizontal_move_speed
	
	if not is_on_floor():
		velocity.y += gravity * delta

func handle_jump():
	if((is_on_floor() or rod_line_connected) and Input.is_action_just_pressed("jump")):
		velocity.y = -jump_velocity
		rod_line_connected = false
		
func check_fall_death():
	if global_position.y > Globals.lower_y_bound_pixels + 150:
		fell_down.emit()
		set_process(false)

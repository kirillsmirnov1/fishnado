class_name FishNado extends Area2D


signal player_entered


@export var speed: float = 1
@export var speed_invisible: float = 10
@export var slowdown_timer: Timer

@onready var current_speed: float = speed_invisible

var speed_mod: float = 1.0

func _process(delta):
	global_position.x += delta * current_speed * speed_mod
	pass


func set_active(active: bool):
	set_process(active)
	visible = active


func _on_player_body_entered(body):
	player_entered.emit()


func _on_screen_visibility_screen_entered():
	print("fishnado visible")
	current_speed = speed
	pass # Replace with function body.


func _on_screen_visibility_screen_exited():
	print("fishnado not visible")
	current_speed = speed_invisible
	pass # Replace with function body.


func activate_slow_down():
	speed_mod = 0.25
	slowdown_timer.start()

func _on_slowdown_timer_timeout():
	speed_mod = 1

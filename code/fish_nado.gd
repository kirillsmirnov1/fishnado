class_name FishNado extends Area2D


signal player_entered


@export var speed: float = 1
@export var speed_invisible: float = 10
@export var speed_change_rate: float = 1


@onready var target_speed: float = speed
@onready var current_speed: float = speed / 3


func _process(delta):
	current_speed = move_toward(current_speed, target_speed, speed_change_rate * delta)
	global_position.x += delta * current_speed
	print("fishnado current speed " + str(current_speed))
	pass


func set_active(active: bool):
	set_process(active)
	visible = active


func _on_player_body_entered(body):
	player_entered.emit()


func _on_screen_visibility_screen_entered():
	print("fishnado visible")
	target_speed = speed
	pass # Replace with function body.


func _on_screen_visibility_screen_exited():
	print("fishnado not visible")
	target_speed = speed_invisible
	pass # Replace with function body.

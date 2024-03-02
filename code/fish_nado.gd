class_name FishNado extends Area2D


signal player_entered


@export var speed: float = 1
@export var speed_invisible: float = 10

@onready var current_speed: float = speed


func _process(delta):
	global_position.x += delta * current_speed
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

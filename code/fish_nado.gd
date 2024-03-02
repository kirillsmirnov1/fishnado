class_name FishNado extends Area2D


signal player_entered


@export var speed: float = 1


func _process(delta):
	global_position.x += delta * speed


func set_active(active: bool):
	set_process(active)
	visible = active


func _on_player_body_entered(body):
	player_entered.emit()

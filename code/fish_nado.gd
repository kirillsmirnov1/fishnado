class_name FishNado extends Area2D

@export var speed: float = 1

func _process(delta):
	global_position.x += delta * speed

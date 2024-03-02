class_name CameraControl extends Camera2D

@export var horizontal_offset: int = 50
@export var target: Node2D

func _process(delta):
	global_position.x = target.global_position.x + horizontal_offset

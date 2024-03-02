class_name CameraControl extends Camera2D

@export var horizontal_offset: int = 50
@export var target: Node2D

func _process(delta):
	var next_pos = target.global_position.x + horizontal_offset
	global_position.x = max(next_pos, global_position.x)

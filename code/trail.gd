class_name Trail extends Line2D

var queue : Array
@export var MAX_LENGTH : int = 40

func _process(_delta):
	var pos = _get_position()
	
	queue.push_front(pos)
	
	if queue.size() > MAX_LENGTH:
		queue.pop_back()
	
	clear_points()
	
	for point in queue:
		add_point(to_local(point))

func _get_position():
	return global_position

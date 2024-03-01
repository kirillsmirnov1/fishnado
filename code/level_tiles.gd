class_name LevelTiles extends TileMap

@export var ground_y: int = 7
@export var ground_start_width: int = 10

func _ready():
	var x: int = ground_start_width
	while(x < 100):
		var next_ground_platform_length = randi_range(3, 10)
		var points: Array
		
		for i in range(x, x + next_ground_platform_length):
			points.append(Vector2i(i, ground_y))
		
		x += next_ground_platform_length
		set_cells_terrain_connect(0, points, 0, 0)
		
		
		points.clear()
		var next_ground_gap = randi_range(1, 5)
		for i in range(x, x + next_ground_gap):
			points.append(Vector2i(i, 0))
		
		x += next_ground_gap
		set_cells_terrain_connect(0, points, 0, 1)
		
	pass

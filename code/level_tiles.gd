class_name LevelTiles extends TileMap

@export var ground_y: int = 7
@export var ground_start_width: int = 10

func _ready():
	var x: int = ground_start_width
	while(x < 300):
		var next_ground_platform_length = randi_range(3, 10)
		spawn_platform(0, ground_y, x, x + next_ground_platform_length)
		x += next_ground_platform_length
		
		var next_ground_gap = randi_range(1, 5)
		spawn_platform(0, 0, x, x + next_ground_gap)
		x += next_ground_gap
		
	pass

func spawn_platform(terrain: int, y: int, x_from: int, x_to: int):
	var points: Array
	for x in range(x_from, x_to):
		points.append(Vector2i(x, y))
	set_cells_terrain_connect(0, points, 0, terrain)
	
	

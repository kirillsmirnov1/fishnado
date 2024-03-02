class_name LevelTiles extends TileMap

@export var ground_start_width: int = 10
@export var ground_spawn_probability: float = 0.3

@onready var ground_y: int = Globals.lower_y_bound_tiles

func _ready():
	var x: int = ground_start_width
	while(x < 300):
		var spawn_ground: bool = randf() < ground_spawn_probability
		var y = ground_y if spawn_ground else randi_range(0, ground_y)
		var x_from = x + randi_range(-1, 1)
		var x_to = x_from + randi_range(3, 5)
		
		spawn_platform(1, y, x_from, x_to)
		
		x = x_to
		
	pass

func spawn_platform(terrain: int, y: int, x_from: int, x_to: int):
	var points: Array
	for x in range(x_from, x_to):
		points.append(Vector2i(x, y))
	set_cells_terrain_connect(0, points, 0, terrain)
	
	

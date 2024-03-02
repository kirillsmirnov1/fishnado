class_name ItemSpawn extends Node2D


signal on_item_collected(type: ItemType.ItemType, global_position: Vector2)


@export var items: Array[ItemData] = []
@export var item_scene: PackedScene


func _on_platform_spawn(data: PlatformSpawnData):
	var roll = randf()
	print("roll " + str(roll))
	var probability_accumulated: float = 0.0
	
	for item: ItemData in items:
		probability_accumulated += item.probability
		if roll <= probability_accumulated: 
			spawn_item(item, data)
			return
	
func spawn_item(item_data: ItemData, platform_data: PlatformSpawnData):
	var new_item = item_scene.instantiate() as Item
	new_item.setup(item_data)
	add_child(new_item)
	new_item.global_position = Vector2((platform_data.x_range.x + platform_data.x_range.y) / 2.0, platform_data.y - 15)

func item_collected(type, global_position):
	on_item_collected.emit(type, global_position)
	

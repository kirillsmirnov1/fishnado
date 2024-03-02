class_name ItemSpawn extends Node2D

enum ItemType{
	Coin,
	Wings,
	FishSlowdown
}

@export var item_scene: PackedScene

func _on_platform_spawn(data: PlatformSpawnData):
	var new_item = item_scene.instantiate() as Item
	add_child(new_item)
	new_item.global_position = Vector2((data.x_range.x + data.x_range.y) / 2.0, data.y - 15)

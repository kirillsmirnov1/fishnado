class_name Item extends Area2D

@export var sprite: Sprite2D

var type: ItemType.ItemType

func setup(data: ItemData):
	type = data.type
	sprite.texture = data.sprite

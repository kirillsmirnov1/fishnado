class_name Item extends Area2D

@export var sprite: Sprite2D

var type: ItemType.ItemType
var collected: bool = false

func setup(data: ItemData):
	type = data.type
	sprite.texture = data.sprite


func _on_player_entered(body):
	if collected: return
	collected = true
	
	print("player collected " + str(type))
	(get_parent() as ItemSpawn).item_collected(type, global_position)
	queue_free()
	pass # Replace with function body.

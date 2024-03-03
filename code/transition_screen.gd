# TransitionScreen
extends CanvasLayer


@export var bg: ColorRect
@export var timer_0_5: Timer


func _ready():
	var t = create_tween()
	t.tween_property(bg, "modulate", Color(1, 1, 1, 0), 0.5)
	await t.finished
	visible = false


func reload_scene():
	visible = true
	
	var t = create_tween()
	t.tween_property(bg, "modulate", Color(1, 1, 1, 1), 0.5)
	await t.finished
	
	await get_tree().reload_current_scene()
	timer_0_5.start()
	await timer_0_5.timeout

	t = create_tween()
	t.tween_property(bg, "modulate", Color(1, 1, 1, 0), 0.5)

	await t.finished
	
	visible = false 

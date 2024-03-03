# TransitionScreen
extends CanvasLayer

@export var text_tween_duration: float = 0.5

@export var bg: ColorRect
@export var timer_0_5: Timer
@export var lines_parent: Control
@export var title: RichTextLabel

func _ready():
	var lines: Array = lines_parent.get_children()
	
	title.modulate = Color.TRANSPARENT
	for line: Label in lines:
		line.modulate = Color.TRANSPARENT
	
	var t = create_tween()
	
	# Showing lines one by one
	for i in range(0, lines.size()):
		t.tween_property(lines[i], "modulate", Color.WHITE, text_tween_duration)
		if i > 0:
			t.parallel().tween_property(lines[i-1], "modulate", Color.WEB_GRAY, text_tween_duration)	
		t.tween_interval(2 * text_tween_duration)
	
	# A short pause
	t.tween_interval(2 * text_tween_duration)
	
	# Hide lines
	t.tween_interval(0)
	for line in lines:
		t.parallel().tween_property(line, "modulate", Color.TRANSPARENT, text_tween_duration)
	
	t.tween_property(title, "modulate", Color(1, 1, 1, 1), text_tween_duration)
	t.tween_interval(4 * text_tween_duration)
	t.tween_property(bg, "modulate", Color(1, 1, 1, 0), text_tween_duration)
	
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

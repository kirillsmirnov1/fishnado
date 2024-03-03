class_name GameOverScreen extends CanvasLayer


signal restart_button_pressed


@export var root: Control
@export var score_label: Label


func _on_restart_button_pressed():
	restart_button_pressed.emit()


func display(data: GameOverData):
	visible = true
	
	if data.new_best_score:
		score_label.text = "NEW BEST SCORE\nscore: " + str(data.score)
	else:
		score_label.text = "score: " + str(data.score) + "\nbest: " + str(data.best_score)
	
	var t = create_tween()
	t.tween_property(root, "modulate", Color.WHITE, 0.5).from(Color.TRANSPARENT)

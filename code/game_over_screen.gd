class_name GameOverScreen extends CanvasLayer


signal restart_button_pressed


@export var score_label: Label


func _on_restart_button_pressed():
	restart_button_pressed.emit()


func display(data: GameOverData):
	visible = true
	
	if data.new_best_score:
		score_label.text = "NEW BEST SCORE\nscore: " + str(data.score)
	else:
		score_label.text = "score: " + str(data.score) + "\nbest: " + str(data.best_score)

class_name GamePlayUI extends CanvasLayer

@onready var score_text: RichTextLabel = $Control/ScoreText

func set_score(new_score: int):
	score_text.text = "[right]" + str(new_score)

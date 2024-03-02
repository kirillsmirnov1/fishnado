class_name GameOverScreen extends CanvasLayer


signal restart_button_pressed


func _on_restart_button_pressed():
	restart_button_pressed.emit()

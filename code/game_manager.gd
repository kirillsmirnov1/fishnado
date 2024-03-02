class_name GameManager extends Node2D

enum State {Game, GameOver}

@export var fishnado: FishNado

var state: State

func _ready():
	state = State.Game
	# fishnado.set_active(false)
	pass


func _on_player_entered_fishnado():
	print("player entered fishnado")
	if state == State.Game:
		game_over()


func _on_player_fell_down():
	print("player fell down")
	if state == State.Game:
		game_over()


func game_over():
	state = State.GameOver
	print("Game Over")
	get_tree().reload_current_scene()

class_name GameManager extends Node2D

enum State {Game, GameOver}

@export var fishnado: FishNado
@export var game_over_ui: GameOverScreen
@export var player: Player

var state: State

func _ready():
	state = State.Game
	game_over_ui.visible = false
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
	game_over_ui.visible = true
	player.set_process(false)
	player.visible = false


func _on_game_over_screen_restart_button_pressed():
	print("Reloading scene")
	get_tree().reload_current_scene()

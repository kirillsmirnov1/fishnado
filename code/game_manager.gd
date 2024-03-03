class_name GameManager extends Node2D

enum State 
{
	Start,
	Game, 
	GameOver
}

@export var fishnado: FishNado
@export var game_over_ui: GameOverScreen
@export var player: Player
@export var cam: Camera2D

@onready var game_play_ui: GamePlayUI = $UI/GamePlayUI

var state: State
var start_pos: int
var points_distance: int = 0 
var points_collected: int = 0
var points_total: int = 0


func _ready():
	beginning_of_game()

	
func _process(delta):
	if Globals.debug: 
		handle_debug_input()
	update_points()


func _on_player_entered_fishnado():
	print("player entered fishnado")
	if state == State.Game:
		game_over()


func _on_player_fell_down():
	print("player fell down")
	if state != State.GameOver:
		game_over()


func _on_start_trigger_player_entered(body):
	if state == State.Start:
		start_game()


func beginning_of_game():
	state = State.Start
	AudioManager.start_idle_music()
	game_play_ui.visible = false
	game_over_ui.visible = false
	
	fishnado.set_process(false)


func start_game():
	state = State.Game
	game_play_ui.visible = true
	start_pos = cam.global_position.x
	fishnado.set_active(true)
	AudioManager.start_action_music()
	
	
func game_over():
	player.disable_reel()
	state = State.GameOver
	print("Game Over")
	
	var game_over_data = GameOverData.new()
	game_over_data.new_best_score = points_total > Globals.best_score
	Globals.best_score = points_total
	game_over_data.score = points_total
	game_over_data.best_score = Globals.best_score
	
	game_over_ui.display(game_over_data)
	
	game_play_ui.visible = false
	player.set_process(false)
	player.visible = false
	AudioManager.start_idle_music()
	AudioManager.play_game_over_sound()


func update_points():
	if state != State.Game: return 
	
	points_distance = (cam.global_position.x - start_pos) / 40
	points_total = points_distance + points_collected
	
	game_play_ui.set_score(points_total)


func _on_game_over_screen_restart_button_pressed():
	print("Reloading scene")
	TransitionScreen.reload_scene()
	AudioManager.play_restart_sound()


func handle_debug_input():
	if Input.is_action_just_pressed("1"):
		player.activate_wings(true)


func _on_item_collected(type: ItemType.ItemType, global_position: Vector2):
	match type:
		ItemType.ItemType.Coin: 
			points_collected += 10
			AudioManager.play_coin_sound()
			pass
		ItemType.ItemType.Wings:
			points_collected += 30
			player.activate_wings(true)
			AudioManager.play_powerup_sound()
			pass
		ItemType.ItemType.FishSlowdown:
			points_collected += 20
			fishnado.activate_slow_down()
			player.speed_mod = 2
			$Timers/SpeedupTimer.start()
			AudioManager.play_powerup_sound()
			pass



func _on_speedup_timer_timeout():
	fishnado.disable_slowdown()
	player.speed_mod = 1.0
	pass # Replace with function body.

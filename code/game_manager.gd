class_name GameManager extends Node2D

enum State {Game, GameOver}

@export var fishnado: FishNado
@export var game_over_ui: GameOverScreen
@export var player: Player
@export var cam: Camera2D

@onready var game_play_ui: GamePlayUI = $UI/GamePlayUI

var state: State
var start_pos: int
var points_distance: int = 0 

func _ready():
	state = State.Game
	game_over_ui.visible = false
	start_pos = cam.global_position.x
	# fishnado.set_active(false)
	pass

func _process(delta):
	handle_debug_input()
	update_points()


func _on_player_entered_fishnado():
	print("player entered fishnado")
	if state == State.Game:
		game_over()


func _on_player_fell_down():
	print("player fell down")
	if state == State.Game:
		game_over()

func update_points():
	points_distance = (cam.global_position.x - start_pos) / 40
	game_play_ui.set_score(points_distance)
	
	
func game_over():
	state = State.GameOver
	print("Game Over")
	game_over_ui.visible = true
	player.set_process(false)
	player.visible = false


func _on_game_over_screen_restart_button_pressed():
	print("Reloading scene")
	get_tree().reload_current_scene()

func handle_debug_input():
	if Input.is_action_just_pressed("1"):
		player.activate_wings(true)


func _on_item_collected(type: ItemType.ItemType, global_position: Vector2):
	match type:
		ItemType.ItemType.Coin: 
			#todo
			pass
		ItemType.ItemType.Wings:
			player.activate_wings(true)
			pass
		ItemType.ItemType.FishSlowdown:
			#todo
			pass
	pass # Replace with function body.

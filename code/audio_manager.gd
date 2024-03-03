# AudioManager
extends Node


@export var music_tween_duration: float = 0.5


@export var action_music: AudioStreamPlayer
@export var idle_music: AudioStreamPlayer


var playing_action_music: bool = true

func _ready():
	start_idle_music()
	

func start_action_music():
	if playing_action_music: return 
	playing_action_music = true
	
	action_music.playing = true
	
	var tween = create_tween()
	tween.tween_property(action_music, "volume_db", -15, music_tween_duration)
	tween.parallel().tween_property(idle_music, "volume_db", -80, music_tween_duration)
	

func start_idle_music():
	if not playing_action_music: return
	playing_action_music = false
	
	idle_music.playing = true
	
	var tween = create_tween()
	tween.tween_property(action_music, "volume_db", -80, music_tween_duration)
	tween.parallel().tween_property(idle_music, "volume_db", 0, music_tween_duration)


func play_game_over_sound():
	$game_over_sound.play()
	
func play_coin_sound():
	$coin_sound.play()
	
func play_powerup_sound():
	$power_up_sound.play()
	
func play_jump_sound():
	$jump.play()
	
func play_wing_sound():
	$wing_flap.play()
	
func play_restart_sound():
	$restart.play()
	
	
	
	
	
	
	
	
	

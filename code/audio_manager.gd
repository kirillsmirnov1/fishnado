# AudioManager
extends Node


@export var action_music: AudioStreamPlayer
@export var idle_music: AudioStreamPlayer


var playing_action_music: bool = true

func _ready():
	start_idle_music()
	

func start_action_music():
	if playing_action_music: return 
	playing_action_music = true
	
	action_music.playing = true
	idle_music.playing = false
	pass

func start_idle_music():
	if not playing_action_music: return
	playing_action_music = false
	
	action_music.playing = false
	idle_music.playing = true
	pass

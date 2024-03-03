# class_name Globals 
extends Node


@export var lower_y_bound_tiles: int = 7
@export var tile_pixel_width: int = 18

@onready var lower_y_bound_pixels: int = lower_y_bound_tiles * tile_pixel_width


var debug: bool = false


var best_score: int = 0:
	set(val):
		if val > best_score:
			best_score = val
			config.set_value("player", "best_score", val)
			config.save("user://save.cfg")
			print("new best score: " + str(val))
			

var config: ConfigFile


func _ready():
	init_config()

	
func init_config():
	config = ConfigFile.new()	
	config.load("user://save.cfg")
	best_score = config.get_value("player", "best_score", 0)	

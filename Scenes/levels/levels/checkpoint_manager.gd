extends Node

var last_location
var player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_parent().get_node("main_character")
	last_location = player.global_position

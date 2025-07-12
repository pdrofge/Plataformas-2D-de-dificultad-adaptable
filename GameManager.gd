extends Node


var last_scene_path : String = ""
var path_selected : String = ""
var lifes
var max_lifes


func set_last_scene(path : String) -> void:
	last_scene_path = path
	
	
func set_lifes(l : int, ml : int) -> void:
	lifes = l
	max_lifes = ml
	
func set_path(p : String) -> void:
	path_selected = p

func get_last_scene() -> String:
	return last_scene_path

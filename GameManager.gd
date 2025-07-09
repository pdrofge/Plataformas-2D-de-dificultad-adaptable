extends Node


var last_scene_path : String = ""

func set_last_scene(path : String) -> void:
	last_scene_path = path

func get_last_scene() -> String:
	return last_scene_path

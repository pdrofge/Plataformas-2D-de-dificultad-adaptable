extends Node


var last_scene_path : String = ""
var path_selected : String = ""
var lifes
var max_lifes
var result


# === Recursos precargados para pantalla de resultados ===

var results_scene = preload("res://Scenes/screens/results_screen.tscn")

var mark_textures = {
	"A": preload("res://images/results/a_mark.png"),
	"B": preload("res://images/results/b_mark.png"),
	"C": preload("res://images/results/c_mark.png")
}

var mark_music = {
	"A": preload("res://music/calification/a_mark.mp3"),
	"B": preload("res://music/calification/b_mark.mp3"),
	"C": preload("res://music/calification/c_mark.mp3")
}

func set_last_scene(path : String) -> void:
	last_scene_path = path		
	
func set_lifes(l : int, ml : int) -> void:
	lifes = l
	max_lifes = ml
	
func set_path(p : String) -> void:
	path_selected = p

func get_last_scene() -> String:
	return last_scene_path

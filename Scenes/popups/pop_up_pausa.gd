extends Node2D

func _ready():
	center_popup()

func center_popup():
	var viewport_size = get_viewport().size
	position = viewport_size / 2
	

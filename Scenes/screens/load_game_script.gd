extends Button


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.load_game()
	print("Datos cargados:", Global.game_data)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _on_pressed() -> void:
	if "next_level" in Global.game_data:
		var next_level = Global.game_data["next_level"]
		match next_level:
			0:
				get_tree().change_scene_to_file("res://Scenes/levels/levels/tutorial.tscn")
			1:
				get_tree().change_scene_to_file("res://Scenes/levels/levels/level1.tscn")
			2:
				get_tree().change_scene_to_file("res://Scenes/levels/levels/level2.tscn")
	else:
		print("no progreso guardado")

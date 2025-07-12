extends Button


func _on_pressed() -> void:
		
		var this_level = GameManager.get_last_scene()
		if this_level == "res://Scenes/levels/levels/tutorial.tscn":
			get_tree().change_scene_to_file("res://Scenes/levels/levels/level1.tscn")
		elif this_level == "res://Scenes/levels/levels/level1.tscn":
			pass
	

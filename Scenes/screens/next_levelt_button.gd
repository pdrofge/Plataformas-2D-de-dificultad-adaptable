extends Button

var lifes = GameManager.lifes
var max_lifes = GameManager.max_lifes
var path_selected = GameManager.path_selected

func _on_pressed() -> void:
		
		var music = get_parent().get_node("music")
		music.stop()
		
		var sound = get_parent().get_node("SelectSound")
		if not sound.playing:
			sound.play()

		await get_tree().create_timer(sound.stream.get_length()).timeout
		var this_level = GameManager.get_last_scene()
		if this_level == "res://Scenes/levels/levels/tutorial.tscn":
			var current_level = 0
			Global.game_data["next_level"] = 1
			Global.game_data["scores"][current_level] = GameManager.result
			Global.save_game()
			print("Datos guardados en Global:", Global.game_data)
			get_tree().change_scene_to_file("res://Scenes/levels/levels/level1.tscn")
		elif this_level == "res://Scenes/levels/levels/level1.tscn":
			var current_level = 1
			Global.game_data["next_level"] = 2
			Global.game_data["scores"][current_level] = GameManager.result
			Global.save_game()
			print("Datos guardados en Global:", Global.game_data)
			get_tree().change_scene_to_file("res://Scenes/levels/levels/level2.tscn")
		elif this_level == "res://Scenes/levels/levels/level2.tscn":
			var current_level = 2
			Global.game_data["next_level"] = 2
			Global.game_data["scores"][current_level] = GameManager.result
			Global.save_game()
			print("Datos guardados en Global:", Global.game_data)
			get_tree().change_scene_to_file("res://Scenes/screens/final_screen.tscn")


func _on_mouse_entered() -> void:
	var sound = get_parent().get_node("HoverSound")
	if not sound.playing:
		sound.play()

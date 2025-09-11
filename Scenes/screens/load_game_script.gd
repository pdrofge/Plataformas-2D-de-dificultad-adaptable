extends Button



func _ready() -> void:
	Global.load_game()
	print("Datos cargados:", Global.game_data)



func _on_pressed() -> void:
	if Global.game_data["next_level"] != 0:
		var music = get_parent().get_node("backgroundMusic")
		music.stop()
		
		var sound = get_parent().get_node("SelectSound")
		if not sound.playing:
			sound.play()

		await get_tree().create_timer(sound.stream.get_length()).timeout
		var next_level = Global.game_data["next_level"]
		match next_level:
			1:
				Trans.change_scene("res://Scenes/levels/levels/level1.tscn")
			2:
				Trans.change_scene("res://Scenes/levels/levels/level2.tscn")
	else:
		var sound = get_parent().get_node("errorSound")
		if not sound.playing:
			sound.play()
		
func _on_mouse_entered() -> void:
	var sound = get_parent().get_node("HoverSound")
	if not sound.playing:
		sound.play()

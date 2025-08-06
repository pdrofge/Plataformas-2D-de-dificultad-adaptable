extends Button


func _on_pressed() -> void:
		
		var music = get_parent().get_node("music")
		music.stop()
		
		var sound = get_parent().get_node("SelectSound")
		if not sound.playing:
			sound.play()

		await get_tree().create_timer(sound.stream.get_length()).timeout
		get_tree().change_scene_to_file(GameManager.get_last_scene())
		
		
	


func _on_mouse_entered() -> void:
	var sound = get_parent().get_node("HoverSound")
	if not sound.playing:
		sound.play()

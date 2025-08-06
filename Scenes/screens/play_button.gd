extends Button


func _on_pressed() -> void:
		
	if not $SelectSound.playing:
		$SelectSound.play()

	await get_tree().create_timer($SelectSound.stream.get_length()).timeout
	get_tree().change_scene_to_file("res://Scenes/levels/levels/tutorial.tscn")


func _on_mouse_entered() -> void:
	if not $HoverSound.playing:
		$HoverSound.play()

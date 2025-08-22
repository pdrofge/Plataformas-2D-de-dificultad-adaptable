extends Button

func _on_pressed() -> void:
	var sound = get_parent().get_node("pauseSound")
	if not sound.playing:
		sound.play()

	await get_tree().create_timer(sound.stream.get_length()).timeout
	
	var popup = get_parent().get_node("popUpPausa") as Panel
	popup.set_anchors_preset(Control.PRESET_CENTER, true)
	popup.set_offset(SIDE_LEFT, 0)
	popup.set_offset(SIDE_TOP, 0)
	popup.set_offset(SIDE_RIGHT, 0)
	popup.set_offset(SIDE_BOTTOM, 0)
	popup.visible = true
	get_tree().paused = true

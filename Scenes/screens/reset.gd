extends Button


func _on_pressed() -> void:
	var sound
	if Global.game_data["next_level"] == 0:
		sound = get_parent().get_node("errorSound")
	else:
		sound = get_parent().get_node("SelectSound")
	if not sound.playing:
		sound.play()
	Global.reset_game_data()


func _on_mouse_entered() -> void:
	var sound = get_parent().get_node("HoverSound")
	if not sound.playing:
		sound.play()

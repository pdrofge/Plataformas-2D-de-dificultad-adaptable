extends Button


func _on_pressed() -> void:
	get_tree().quit()

func _on_mouse_entered() -> void:
	var sound = get_parent().get_node("HoverSound")
	if not sound.playing:
		sound.play()

extends Button


func _on_pressed() -> void:
		
	var music = get_parent().get_node("backgroundMusic")
	music.stop()
		
	var sound = get_parent().get_node("SelectSound")
	if not sound.playing:
		sound.play()
	#get_tree().change_scene_to_file("res://Scenes/levels/levels/tutorial.tscn")
	Trans.change_scene("res://Scenes/levels/levels/tutorial.tscn")

func _on_mouse_entered() -> void:
	var sound = get_parent().get_node("HoverSound")
	if not sound.playing:
		sound.play()

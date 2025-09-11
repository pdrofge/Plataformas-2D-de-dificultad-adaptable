extends Button





func _on_pressed() -> void:
	get_tree().paused = false
	
	Trans.change_scene("res://Scenes/screens/main_screen.tscn")

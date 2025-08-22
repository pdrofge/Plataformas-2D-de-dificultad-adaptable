extends Panel

func _on_resume_button_pressed() -> void:
	get_tree().paused = false
	hide()

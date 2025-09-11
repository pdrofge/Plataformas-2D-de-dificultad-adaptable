extends Button



func _ready() -> void:
	pass 



func _process(delta: float) -> void:
	pass


func _on_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/screens/main_screen.tscn")

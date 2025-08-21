extends Button


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass




func _on_pressed() -> void:
	var sound = get_parent().get_node("pauseSound")
	if not sound.playing:
		sound.play()

	await get_tree().create_timer(sound.stream.get_length()).timeout
	
	var popup = get_parent().get_node("popUpPausa")
	popup.visible = true
	get_tree().paused = true
	

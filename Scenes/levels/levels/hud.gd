extends CanvasLayer



func loadLifes():
	
	var player = get_tree().get_current_scene().find_child("main_character", true, false)
	if player:
		var lifes = player.lifes
		var width := 0

		match lifes:
			3:
				width = 156
			2:
				width = 107
			1:
				width = 53
			_:
				width = 0

		$heartsFull.custom_minimum_size.x = width
		print("Redimensionar Control 'heartsFull' a ", $heartsFull.custom_minimum_size)

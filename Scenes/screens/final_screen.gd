extends Control



func _ready() -> void:
	var scores = Global.game_data["scores"]  
	var total_score = scores[0] + scores[1] + scores[2]
	var mark = ""
	if total_score >= 25:
		mark = "A"
		$imagenResultados.texture = load("res://images/results/a_mark.png")
		$music.stream = load("res://music/calification/a_mark.mp3")
	elif total_score >= 15:
		mark = "B"
		$imagenResultados.texture = load("res://images/results/b_mark.png")
		$music.stream = load("res://music/calification/b_mark.mp3")
	else:
		mark = "C"
		$imagenResultados.texture = load("res://images/results/c_mark.png")
		$music.stream = load("res://music/calification/c_mark.mp3")
	
	$music.play()
	$mark.text = mark

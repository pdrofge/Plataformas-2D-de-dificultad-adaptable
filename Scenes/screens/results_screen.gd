extends Control

var lifes = GameManager.lifes
var max_lifes = GameManager.max_lifes
var path_selected = GameManager.path_selected

func _ready():
	if path_selected == "":
		if lifes == max_lifes:
			$imagenResultados.texture = load("res://images/results/a_mark.png")
			$mark.text = "A"
		elif lifes == 1:
			$imagenResultados.texture = load("res://images/results/c_mark.png")
			$mark.text = "C"
		else:
			$imagenResultados.texture = load("res://images/results/b_mark.png")
			$mark.text = "B"
		$lifesResult.text = str(lifes)
		$pathResult.text = "-"
	else:
		pass
		
	
	if $mark.text == "A":
		$music.stream = load("res://music/calification/a_mark.mp3")
	elif $mark.text == "B":
		$music.stream = load("res://music/calification/b_mark.mp3")
	else:
		$music.stream = load("res://music/calification/c_mark.mp3")
	$music.play()

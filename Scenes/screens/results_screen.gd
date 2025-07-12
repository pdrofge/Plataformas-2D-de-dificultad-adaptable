extends Control

var lifes = GameManager.lifes
var max_lifes = GameManager.max_lifes
var path_selected = GameManager.path_selected

func _ready():
	if path_selected == "":
		if lifes == max_lifes:
			$imagenResultados.texture = load("res://images/results/a_mark.png")
			$lifesResult.text = str(lifes)
			$pathResult.text = "-"
		elif lifes == 1:
			$imagenResultados.texture = load("res://images/results/c_mark.png")
			$lifesResult.text = str(lifes)
			$pathResult.text = "-"
		else:
			$imagenResultados.texture = load("res://images/results/b_mark.png")
			$lifesResult.text = str(lifes)
			$pathResult.text = "-"
	else:
		pass

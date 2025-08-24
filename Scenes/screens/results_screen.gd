extends Control

var lifes = GameManager.lifes
var max_lifes = GameManager.max_lifes
var path_selected = GameManager.path_selected

func _ready():
	if path_selected == "":
		if lifes == max_lifes:
			$imagenResultados.texture = GameManager.mark_textures["A"]
			$mark.text = "A"
		elif lifes == 1:
			$imagenResultados.texture = GameManager.mark_textures["C"]
			$mark.text = "C"
		else:
			$imagenResultados.texture = GameManager.mark_textures["B"]
			$mark.text = "B"
		$pathResult.text = "-"
	else:
		$pathResult.text = path_selected
		if path_selected == "A":
			if lifes == max_lifes or lifes == max_lifes - 1:
				$imagenResultados.texture = GameManager.mark_textures["A"]
				$mark.text = "A"
			else:
				$imagenResultados.texture = GameManager.mark_textures["B"]
				$mark.text = "B"
		else:
			if lifes == max_lifes or lifes == max_lifes - 1:
				$imagenResultados.texture = GameManager.mark_textures["B"]
				$mark.text = "B"
			else:
				$imagenResultados.texture = GameManager.mark_textures["C"]
				$mark.text = "C"
			
	$lifesResult.text = str(lifes)
	
	# Música precargada
	var grade = $mark.text
	$music.stream = GameManager.mark_music[grade]
	
	match grade:
		"A": GameManager.result = 10
		"B": GameManager.result = 5
		_:  GameManager.result = 0
		
	$music.play()

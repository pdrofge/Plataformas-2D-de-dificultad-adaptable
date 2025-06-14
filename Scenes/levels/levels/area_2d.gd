extends Area2D

@export var tutorial_text: String  # Texto a mostrar
var has_been_triggered = false  # Para que se muestre solo una vez

# Ajusta la ruta si cambiaste el nombre del Label
@onready var ui_label = get_tree().get_root().get_node("tutorial/Interfaz/TutorialLabel1")

func _on_body_entered(body):
	if body.name == "Player" and not has_been_triggered:
		ui_label.text = tutorial_text
		ui_label.show()
		has_been_triggered = true
		# Opcional: ocultar el mensaje después de unos segundos
		await get_tree().create_timer(3.0).timeout
		ui_label.hide()

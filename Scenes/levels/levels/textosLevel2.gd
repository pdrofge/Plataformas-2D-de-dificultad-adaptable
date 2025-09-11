extends Node2D

# Diccionario para mapear nombres de TileMap a MarginContainers
@onready var tutorial_texts := {
	"bloqueCaminos": $caminosExplicacion
}

var player: Node2D  
var floor_ray: RayCast2D  

func _ready():
	
	player = get_tree().get_current_scene().find_child("main_character", true, false)


	if player:
		floor_ray = player.get_node_or_null("FLOOR") as RayCast2D
	

func _process(_delta: float) -> void:
	if not floor_ray:
		return  #No hacer nada si no encontramos previamente el rc

	var active_text_name: String = ""
	if floor_ray.is_colliding():
		var collider: Node = floor_ray.get_collider()
		if collider and tutorial_texts.has(collider.name):
			active_text_name = collider.name

	#Aquí mostramos textos que pisamos
	for name in tutorial_texts:
		tutorial_texts[name].visible = (name == active_text_name)

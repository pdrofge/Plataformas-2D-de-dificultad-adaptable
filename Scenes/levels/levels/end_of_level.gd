extends TileMap

var player 
var floor_ray

func _ready() -> void:
	player = get_tree().get_current_scene().find_child("main_character", true, false)
	if player:
		floor_ray = player.get_node_or_null("FLOOR") as RayCast2D

func _physics_process(delta) -> void:
	if floor_ray and floor_ray.is_colliding():
		var collider: Node = floor_ray.get_collider()
		if collider.name == "end_of_level":
			GameManager.set_lifes(player.lifes, player.max_lifes)
			GameManager.set_last_scene(get_tree().current_scene.scene_file_path)
			get_tree().change_scene_to_file("res://Scenes/screens/results_screen.tscn")

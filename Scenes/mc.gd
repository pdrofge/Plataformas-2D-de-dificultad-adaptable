extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0 * 0.95
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var allow_animation:bool = false
var had_jump:bool = false
var max_jumps:int = 2
var count_jumps:int = 0
var leaved_floor:bool = false #para CT
var pared:bool = false
var rcDim = 12
var direction
var down:bool = false
var big_jump_boost = 1.2
var sliding_t = 0.6
var sliding_end: bool = false
var dash: bool = false
var count_dashes = 0
var max_dashes_in_air = 1
var dash_end:bool = false
var dash_boost = 1.25
var hitting1:bool = false
var hitting2:bool = false
var hitting_wr:bool = false
var max_lifes:int = 3 
var lifes:int = 3 
var checkpoint_manager
var initial_pos

func _ready():
	
	checkpoint_manager = get_parent().get_node("CheckpointManager")
	initial_pos = position
	var hud  = get_tree().get_current_scene().find_child("HUD", true, false)
	if hud:
		hud.loadLifes()
	
	$WJ.target_position.x = rcDim
	$HIT1.target_position.x = rcDim
	$HIT2.target_position.x = rcDim
	$HIT3.target_position.x = rcDim
	$sliding_time.wait_time = sliding_t
	
func _physics_process(delta: float) -> void:
	#print($HIT3.target_position)
	if $FLOOR.get_collider():
		var collider = $FLOOR.get_collider().name
		if collider == "spike": #&& $just_damaged.is_stopped(): #lifes == 3 BORRARLO tras probar que funciona
			_changeLifes(-1)
			#$just_damaged.start()
	# Add gravity
	if is_on_floor():
		leaved_floor = false
		allow_animation = true
		had_jump = false
		count_jumps = 0
		count_dashes = 0  # Resetea el dash al tocar el suelo
		
		# Detección de golpe
		"""
		if Input.is_action_just_pressed("Enter") and not hitting1 and not hitting2 and not down and velocity.x == 0:
			hitting1 = true
			hitting2 = false
			if $animaciones.animation != "hit1":
				$animaciones.play("hit1")

		elif Input.is_action_just_pressed("Enter") and hitting1 and not hitting2:
			hitting2 = true  # Marca que se activará "hit2"
		"""
		if Input.is_action_just_pressed("Enter") and not down:
			if velocity.x == 0 and not hitting1 and not hitting2 and not hitting_wr:
				hitting1 = true
				hitting2 = false
				$animaciones.play("hit1")
			elif hitting1 and not hitting2:
				hitting2 = true  # Encadenamiento
			elif velocity.x != 0 and not hitting1 and not hitting2 and not hitting_wr:
				hitting_wr = true
				$animaciones.play("hit_while_running")

			
		if Input.is_action_just_pressed("Enter") and not hitting1 and not hitting2 and not down and velocity.x != 0:
			hitting_wr = true
			if $animaciones.animation != "hit_while_running":
				$animaciones.play("hit_while_running")

		if Input.is_action_pressed("ui_down"):
			down = true
		else:
			down = false

	if not is_on_floor():
		down = false
		if Input.is_action_just_pressed("ui_text_delete") and count_dashes < max_dashes_in_air and direction and not pared:
			dash = true
			dash_end = false
			count_dashes += 1
			$dash_time.start()  # Inicia el temporizador de dash
			$animaciones.play("dash")  # Activa la animación de dash

		if not leaved_floor:
			$CT.start()
			leaved_floor = true
		
		# Aplicamos la gravedad solo si no estamos en dash
		if not dash:
			velocity.y += gravity * delta
		else:
			velocity.y = 0  # Mantener suspendido en el aire

	# Handle jump
	if Input.is_action_just_pressed("ui_accept") and can_jump():
		if count_jumps == 1:
			allow_animation = false
			$animaciones.play("double_jump")
		count_jumps += 1
		if down:
			velocity.y = JUMP_VELOCITY * big_jump_boost
		else:
			velocity.y = JUMP_VELOCITY

	# Movement logic
	if sliding_end:
		velocity.x = 0
		sliding_end = false
	else:
		direction = Input.get_axis("ui_left", "ui_right")

	if dash:
		if direction != 0:
			velocity.x = direction * SPEED * dash_boost  # Aplica el boost de velocidad en dash
		
	else:
		if not down:
			if direction:
				velocity.x = direction * SPEED
			else:
				velocity.x = move_toward(velocity.x, 0, SPEED)

	# Destruir bloques 
	
	for ray in [$HIT1, $HIT2, $HIT3, $WJ]:	
		if ray.is_colliding():
			var collider = ray.get_collider()
		
			if collider is TileMap and collider.name == "destructible" and (hitting1 or hitting2 or hitting_wr):
				var tilemap := collider as TileMap
				var collision_point = tilemap.to_local(ray.get_collision_point())
				var tile_coords = tilemap.local_to_map(collision_point)

				var world_pos = tilemap.to_global(tilemap.map_to_local(tile_coords))
				tilemap.erase_cell(0, tile_coords) 
	
				var break_effect = preload("res://Scenes/BlockBreakEffect.tscn").instantiate()
				break_effect.global_position = tilemap.to_global(world_pos)
				get_tree().current_scene.add_child(break_effect)
	
	# Wall Jump detection
	if $WJ.get_collider():
		var collider = $WJ.get_collider()
		if collider.name == "Walljump_map":
			if velocity.y > 0:
				velocity.y = 0
				count_jumps = 0
				pared = true
				count_dashes = 0
				allow_animation = true	
		else:
			pared = false
	else:
		pared = false

	if down and velocity.x != 0 and $sliding_time.is_stopped():
		$sliding_time.start()

	move_and_slide()
	if not hitting1 and not hitting2 and not hitting_wr: 
		decide_animation()

func can_jump():
	if not hitting1 and not hitting2 and not hitting_wr: #Hay un pequeño retraso al saltar tras atacar
		if had_jump:
			if count_jumps < max_jumps:
				return true
			else:
				return false
		if pared or is_on_floor():
			had_jump = true
			return true
		elif not $CT.is_stopped():
			had_jump = true
			return true

func decide_animation():
	if direction > 0:
		$animaciones.flip_h = false
		$WJ.target_position.x = rcDim
		$HIT1.target_position.x = rcDim
		$HIT2.target_position.x = rcDim
		$HIT3.target_position.x = rcDim
		
	elif direction < 0:
		$animaciones.flip_h = true
		$WJ.target_position.x = -rcDim
		$HIT1.target_position.x = -rcDim
		$HIT2.target_position.x = -rcDim
		$HIT3.target_position.x = -rcDim

	if count_jumps > 1:
		allow_animation = false

	if not allow_animation:
		return

	if dash:
		$animaciones.play("dash")  # Asegura que la animación de dash esté activa
	elif pared:
		$animaciones.play("wall_jump")
	elif down:
		$animaciones.play("down")
	else:
		if velocity.x == 0:
			$animaciones.play("idle")
		elif velocity.x < 0:
			$animaciones.play("run")
		elif velocity.x > 0:
			$animaciones.play("run")

	if velocity.y < 0 and down:
		$animaciones.play("big_jump")
		allow_animation = false
	elif velocity.y < 0:
		$animaciones.play("jump_up")
	if velocity.y > 0:
		$animaciones.play("jump_down")

func animation_finished() -> void:
	var current_animation = $animaciones.animation
	
	match current_animation:
		"hit1":
			if hitting2:
				$animaciones.play("hit2")
			else:
				hitting1 = false
				hitting2 = false
				allow_animation = true
				decide_animation()

		"hit2":
			hitting1 = false
			hitting2 = false
			allow_animation = true
			decide_animation()

		"hit_while_running":
			hitting_wr = false
			allow_animation = true
			decide_animation()

		_:
			# Si no es ninguna de las animaciones de ataque, simplemente desbloquea
			hitting1 = false
			hitting2 = false
			hitting_wr = false
			allow_animation = true

	
	
	
	"""
	var current_animation = $animaciones.animation  # Obtiene la animación actual
	
	if current_animation == "hit1":
		if hitting2: 
			$animaciones.play("hit2")  # Si se presionó Enter en medio de "hit1", activa "hit2"
		hitting1 = false  # Libera la variable al terminar
	
	elif current_animation == "hit2":
		hitting1 = false
		hitting2 = false  # Reseteamos después de "hit2"
	
	if current_animation == "hit_while_running":
		hitting_wr = false
	
	allow_animation = true  # Permitimos otras animaciones después del combo

"""

func _on_ct_timeout() -> void:
	pass

func _on_sliding_time_timeout() -> void:
	sliding_end = true

func _on_dash_time_timeout() -> void:
	dash_end = true
	dash = false  # Termina el dash al acabar el tiempo
	
	

	
	
func _changeLifes(number: int):
	if number < 0:
		var restar = number * -1
		if lifes - restar > 0:
			lifes = lifes - restar
			position = checkpoint_manager.last_location
		else:
			lifes = 0
			position = initial_pos
	else:
		pass
	checkLifes()	
	
func checkLifes():
	
	var hud  = get_tree().get_current_scene().find_child("HUD", true, false)
	if hud:
		hud.loadLifes()
	if lifes == 0:
		GameManager.set_last_scene(get_tree().current_scene.scene_file_path)
		get_tree().change_scene_to_file("res://Scenes/screens/game_over_menu.tscn")	
	#print("Tienes " + str(lifes) + " vidas")
	#habría que moverlo al anterior checkpoint en caso de tener 1 o más vidas

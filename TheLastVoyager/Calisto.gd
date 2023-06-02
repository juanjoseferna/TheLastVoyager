extends Position2D

var Velocidad = Vector2()
var puede_saltar
var puede_disparar = true
export (float) var GRAVEDAD = 6000
export (float) var VEL_MOVIMIENTO = 4000
export (float) var VEL_SALTO = 6000
export (PackedScene) var balaPrinc
export (Vector2) var spawnB_arr
export (Vector2) var spawnB_izq

func _physics_process(delta):
	Globales.flipflop = get_node("Cuerpo/CalistoSpr").flip_h
	
	var paredes_all = get_tree().get_nodes_in_group("pared")
	for pared in paredes_all:
		get_node("Cuerpo").add_collision_exception_with(pared)
		
	Velocidad.y += GRAVEDAD * delta
	Globales.jugador_pos = Velocidad
	spawnB_izq = get_node("Cuerpo/spawBala").position
	
	if (!get_node("Cuerpo/CalistoSpr").flip_h):
		get_node("Cuerpo/spawBala").position = spawnB_izq
	else:
		get_node("Cuerpo/spawBala").position.x *= -1
		
	if(Input.is_action_pressed("tecla_a")):
		Velocidad.x = -VEL_MOVIMIENTO
		get_node("Cuerpo/spawBala").position = spawnB_izq
		get_node("Cuerpo/CalistoSpr").flip_h = false
		if(puede_saltar):
			get_node("animacion_J1").play("j_corriendo")
		
	elif(Input.is_action_pressed("tecla_d")):
		Velocidad.x = VEL_MOVIMIENTO
		get_node("Cuerpo/CalistoSpr").flip_h = true
		if(puede_saltar):
			get_node("animacion_J1").play("j_corriendo")

	else:
		Velocidad.x = 0
		if(puede_saltar):
			get_node("animacion_J1").play("j_idle")
			if(Input.is_action_pressed("tecla_s")):
					get_node("animacion_J1").play("j_agachado")
			if(Input.is_action_pressed("tecla_w")):
					get_node("animacion_J1").play("j_arriba")

	if(Input.is_action_pressed("tecla_espacio") && puede_saltar):
		Velocidad.y = -VEL_SALTO
		get_node("animacion_J1").play("j_salto")

		puede_saltar = false
	
	if(Input.is_action_pressed("ClickIzq") && puede_disparar):
		puede_disparar = false
		get_node("Cuerpo/Tiempo").start()
		var newBala = balaPrinc.instance()
		newBala.global_position = get_node("Cuerpo/spawBala").global_position
		get_tree().get_nodes_in_group("main")[0].add_child(newBala)

	var movimiento = Velocidad * delta
	get_node("Cuerpo").move_and_slide(movimiento)

	if(get_node("Cuerpo").get_slide_collision(get_node("Cuerpo").get_slide_count()-1) != null):
		var obj_colisionado = get_node("Cuerpo").get_slide_collision(get_node("Cuerpo").get_slide_count()-1).collider
		if(obj_colisionado.is_in_group("suelo")):
			puede_saltar = true
		if(obj_colisionado.is_in_group("lava")):
			Globales.muerte()
			
func _on_Tiempo_timeout():
	puede_disparar = true

extends Position2D

var Velocidad = Vector2()
var puede_saltar
export (float) var GRAVEDAD = 2000
export (float) var VEL_MOVIMIENTO = 5000
export (float) var VEL_SALTO = 2100

func _ready():
	pass

func _physics_process(delta):
	Velocidad.y += GRAVEDAD * delta

	if(Input.is_action_pressed("tecla_a")):
		Velocidad.x = -VEL_MOVIMIENTO
		get_node("Cuerpo/CalistoSpr").flip_h = false
		if(puede_saltar):
			get_node("animacion_J1").play("j_corriendo")
		
		if(Input.is_action_just_pressed("tecla_w")):
			get_node("animacion_J1").play("j_diagarr")
			
		elif(Input.is_action_just_pressed("tecla_s")):
			get_node("animacion_J1").play("j_diagab")
			
		elif(!get_node("animacion_J1").is_playing()):
			get_node("animacion_J1").play("j_corriendo")
		
		elif(Input.is_action_just_released("tecla_w") || Input.is_action_just_released("tecla_espacio")):
			pass
		
	elif(Input.is_action_pressed("tecla_d")):
		Velocidad.x = VEL_MOVIMIENTO
		get_node("Cuerpo/CalistoSpr").flip_h = true
		if(puede_saltar):
			get_node("animacion_J1").play("j_corriendo")
		
		if(Input.is_action_just_pressed("tecla_w")):
			get_node("animacion_J1").play("j_diagarr")
			
		elif(Input.is_action_just_pressed("tecla_s")):
			get_node("animacion_J1").play("j_diagab")
			
		elif(Input.is_action_just_released("tecla_w") || Input.is_action_just_released("tecla_espacio")):
			pass
	else:
		Velocidad.x = 0
		get_node("animacion_J1").play("j_idle")

	if(Input.is_action_pressed("tecla_espacio") && puede_saltar):
		Velocidad.y = -VEL_SALTO
		get_node("animacion_J1").play("j_salto")

		puede_saltar = false

	var movimiento = Velocidad * delta
	get_node("Cuerpo").move_and_slide(movimiento)

	if(get_node("Cuerpo").get_slide_collision(get_node("Cuerpo").get_slide_count()-1) != null):
		var obj_colisionado = get_node("Cuerpo").get_slide_collision(get_node("Cuerpo").get_slide_count()-1).collider
		if(obj_colisionado.is_in_group("suelo")):
			puede_saltar = true
			

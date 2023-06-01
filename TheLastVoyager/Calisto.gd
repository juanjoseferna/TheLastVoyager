extends Position2D

var Velocidad = Vector2()
var puede_saltar
export (float) var GRAVEDAD = 6000
export (float) var VEL_MOVIMIENTO = 4000
export (float) var VEL_SALTO = 6000

func _ready():
	pass

func _physics_process(delta):
	Velocidad.y += GRAVEDAD * delta

	if(Input.is_action_pressed("tecla_a")):
		Velocidad.x = -VEL_MOVIMIENTO
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
			if(puede_saltar):
				get_node("animacion_J1").play("j_agachado")

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
			

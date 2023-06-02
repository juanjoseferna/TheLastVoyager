extends KinematicBody2D

export (float) var GRAVEDAD = 2000
var Velocidad = Vector2()
export (float) var VEL_MOVIMIENTO = 2000
export (float) var VEL_SALTO = 3500
enum estado {corriendo, saltando, cayendo}
var estado_actual = estado.cayendo

func _ready():
	get_node("AnimationPlayer").play("Enem_run")

func _physics_process(delta):
	Velocidad.y += GRAVEDAD * delta

	if(!get_node("Sprite").flip_h):
	   Velocidad.x = -VEL_MOVIMIENTO
	else:
		Velocidad.x = VEL_MOVIMIENTO

	var movimiento = Velocidad * delta
	move_and_slide(movimiento)

	if(!test_move(transform, Vector2(0,1)) && estado_actual != estado.cayendo && estado_actual != estado.saltando):
		if(rand_range(0, 10) < 5):
			estado_actual = estado.saltando
			get_node("AnimationPlayer").play("Enem_jump")
			Velocidad.y -= VEL_SALTO
		else:
			estado_actual = estado.cayendo
			get_node("Sprite").flip_h = !get_node("Sprite").flip_h
			if(Velocidad.x > 0):
				global_position.x -= 10
			else:
				global_position.x += 10
			Velocidad.x = 0
			global_position.y -= 70

	if(get_slide_collision(get_slide_count()-1) != null):
		var obj_colisionado = get_slide_collision(get_slide_count()-1).collider
		if(obj_colisionado.is_in_group("suelo") && estado_actual != estado.corriendo):
			estado_actual = estado.corriendo
			if(obj_colisionado.is_in_group("agua")):
				muerte_enemigo()
			elif(obj_colisionado.is_in_group("bala")):
				muerte_enemigo()
				obj_colisionado.queue_free()
	
func muerte_enemigo():
	get_node("AnimationPlayer").play("enem_explos")
	yield(get_node("AnimationPlayer"), "animation_finished")
	queue_free()

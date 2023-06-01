extends KinematicBody2D

export var Velocidad = Vector2()
export var potencia = 0

func _ready():
	if(!Globales.flipflop):
		Velocidad.x = -10000
	else:
		Velocidad.x = 10000
	Velocidad.y = 0
	if(Input.is_action_pressed("tecla_w")):
		Velocidad.x = 0
		Velocidad.y = -10000
		

func _physics_process(delta):
	var movimiento = Velocidad * delta

	move_and_slide(movimiento)

extends KinematicBody2D

export var Velocidad = Vector2()
export var potencia = 0
export var vel_bala = 10000

func _ready():
	if(!Globales.flipflop):
		Velocidad.x = -vel_bala
	else:
		Velocidad.x = vel_bala
	Velocidad.y = 0
	if(Input.is_action_pressed("tecla_w")):
		Velocidad.x = 0
		Velocidad.y = -vel_bala
	var suelos_all = get_tree().get_nodes_in_group("suelos")
	var pared_all = get_tree().get_nodes_in_group("pared")
	var lava_all = get_tree().get_nodes_in_group("lava")
	for x in suelos_all + pared_all + lava_all:
		add_collision_exception_with(x)

func _physics_process(delta):
	var movimiento = Velocidad * delta

	move_and_slide(movimiento)

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

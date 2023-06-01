extends KinematicBody2D

var Velocidad = Vector2()
export var potencia = 0

func _ready():
	Velocidad.x = 0
	Velocidad.y = 0 

func _physics_process(delta):
	var movimiento = Velocidad * delta
	move_and_slide(movimiento)

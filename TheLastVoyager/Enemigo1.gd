extends KinematicBody2D

var Velocidad = Vector2()
export (float) var GRAVEDAD = 6000
export (float) var VEL_MOVIMIENTO = 4000
var Vec = Vector2()

export (int, "patrol") var typeMove
var direction := -1

#Maquina de Estados
onready var anim := $AnimationPlayer
var in_move : bool
var in_attack : bool

enum {IDLE, WALK, SHOOT}
var state : int
var new_animation
var current_animation

func _ready():
	travel_to(IDLE)
	
	
func _physics_process(delta):
	type_move()
	stateMachine()
	Velocidad.y += GRAVEDAD * delta
	var movimiento = Velocidad * delta
	move_and_slide(movimiento)
	
func type_move():
	match typeMove:
		0:
			patrol_move()
		1:
			pass
	
func patrol_move():
	Vec.x = Velocidad * direction
	in_move = true
	if test_move(Transform2D(0,position), Vector2.RIGHT):
		direction = -1
	elif test_move(Transform2D(0,position), Vector2.LEFT):
		direction = 1
		
func travel_to(new_state):
	state = new_state
	match state:
		IDLE:
			new_animation = "idle"
		WALK:
			new_animation = "walk"
		SHOOT:
			new_animation = "shoot"
			
func stateMachine():
	if current_animation != new_animation:
		current_animation = new_animation
		anim.play(current_animation)
		
	if is_on_floor():
		if state in [IDLE, SHOOT] and in_move:
			travel_to(WALK)
		if state in [WALK, SHOOT] and in_move:
			travel_to(IDLE)
			
	if state in [IDLE, WALK, SHOOT] and in_attack:
		travel_to(SHOOT)

extends KinematicBody2D

var velocity = Vector2(0,0)
var goForeward = true
var VEL_MOV = 25
var jugador = null
var mult_furia = 6

func _physics_process(delta):
	get_node("animacion_en").play("Enem_run")
	if is_on_wall():
		$Sprite.flip_h = not $Sprite.flip_h
		goForeward = not goForeward
	if goForeward == false:
		velocity.x = VEL_MOV
	else:
		velocity.x = -VEL_MOV
	if jugador != null:
		print(global_position.x,"---------",jugador.global_position.x)
		if global_position.x < jugador.global_position.x:
			velocity.x = VEL_MOV*mult_furia
			$Sprite.flip_h = true
		else:
			velocity.x = -VEL_MOV*mult_furia
			$Sprite.flip_h = false
	velocity = move_and_slide(velocity, Vector2.UP)


func _on_AreaAtaq_body_entered(body):
	if body.is_in_group("jugador"):
		Globales.muerte()
		#Solucionar
	if body.is_in_group("bala"):
		queue_free()
		body.queue_free()

func _on_AreaVision_body_entered(body):
	if body.is_in_group("jugador"):
		jugador = body


func _on_AreaVision_body_exited(body):
	if body.is_in_group("jugador"):
		jugador = null

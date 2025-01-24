extends CharacterBody2D

# Constantes para ajustar velocidad y aceleración
const SPEED = 300
const ACCELERATION = 800
const DRAG = 500

func _physics_process(delta):
	# Obtén las direcciones de entrada del jugador
	var direction_R = Input.get_axis("ui_left", "ui_right")
	var direction_U = Input.get_axis("ui_up", "ui_down")

	# Movimiento horizontal con aceleración
	if direction_R != 0:
		velocity.x = move_toward(velocity.x, direction_R * SPEED, ACCELERATION * delta)
	else:
		velocity.x = move_toward(velocity.x, 0, DRAG * delta)

	# Movimiento vertical con aceleración
	if direction_U != 0:
		velocity.y = move_toward(velocity.y, direction_U * SPEED, ACCELERATION * delta)
	else:
		velocity.y = move_toward(velocity.y, 0, DRAG * delta)

	# Aplica el movimiento utilizando la propiedad velocity
	move_and_slide()

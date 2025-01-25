extends CharacterBody2D

# Constantes para ajustar velocidad y aceleración
const SPEED = 350
const ACCELERATION = 800
const DRAG = 300

const MAX_ANGLE = 15 #cosas tween
const ROTATION_DURATION = 1.0

# Referencia al Tween
var tween = null

func _ready():
	tween = get_tree().create_tween()

	rotation = deg_to_rad(-MAX_ANGLE)

	start_rotation()


func start_rotation():
	tween.tween_property(
		self,                  # Nodo objetivo
		"rotation",             # Propiedad a interpolar
		deg_to_rad(MAX_ANGLE),         # Valor final
		ROTATION_DURATION         # Duración
	).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)

	tween.connect("finished",Callable(self,"_on_tween_completed"))

func _on_tween_completed():
	# Cambiar la dirección de rotación
	if tween:  # Si hay un tween activo, detenerlo
		tween.kill()
		
	tween = get_tree().create_tween()

	var target_angle = 0
	if rotation == deg_to_rad(MAX_ANGLE):
		target_angle = deg_to_rad(-MAX_ANGLE)
	else: 
		deg_to_rad(MAX_ANGLE)
		
	tween.tween_property(
		self,                  # Nodo objetivo
		"rotation",             # Propiedad a interpolar
		deg_to_rad(MAX_ANGLE),         # Valor final
		ROTATION_DURATION         # Duración
	).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)

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

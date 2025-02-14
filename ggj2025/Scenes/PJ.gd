extends CharacterBody2D

# Constantes para ajustar velocidad y aceleración
const SPEED = 350
const ACCELERATION = 800
const DRAG = 300
var can_move = false
var finishloop = false

var target_angle = 6 #cosas tween
const ROTATION_DURATION = 1.5

# Referencia al Tween
var tween = null

func _ready():
	tween = get_tree().create_tween()
	rotation = deg_to_rad(-target_angle)
	start_rotation()
	self.add_to_group("pj")


func start_rotation():
	if tween:  # Si hay un tween activo, detenerlo
		tween.kill()
	
	if(finishloop == false):	
		tween = get_tree().create_tween()

		tween.tween_property(
			self,                  # Nodo objetivo
			"rotation",             # Propiedad a interpolar
			deg_to_rad(target_angle),         # Valor final
			ROTATION_DURATION         # Duración
		).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
		
		target_angle = -target_angle

		tween.connect("finished",Callable(self,"start_rotation"))

func _on_tween_completed():
	# Cambiar la dirección de rotación
	if tween:  # Si hay un tween activo, detenerlo
		tween.kill()
		
	tween = get_tree().create_tween()
	
	target_angle = -target_angle
		
	tween.tween_property(
		self,                  # Nodo objetivo
		"rotation",             # Propiedad a interpolar
		deg_to_rad(target_angle),         # Valor final
		ROTATION_DURATION         # Duración
	).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)

func _physics_process(delta):
	# Obtén las direcciones de entrada del jugador
	var direction_R = Input.get_axis("ui_left", "ui_right")
	var direction_U = Input.get_axis("ui_up", "ui_down")


	# Movimiento horizontal con aceleración
	if direction_R != 0 && can_move:
		velocity.x = move_toward(velocity.x, direction_R * SPEED, ACCELERATION * delta)
		
		if direction_R < 0:
			$AnimatedSprite2D.flip_h = true 
		else:
			$AnimatedSprite2D.flip_h = false 
			
	else:
		velocity.x = move_toward(velocity.x, 0, DRAG * delta)

	# Movimiento vertical con aceleración
	if direction_U != 0 && can_move:
		velocity.y = move_toward(velocity.y, direction_U * SPEED, ACCELERATION * delta)
	else:
		velocity.y = move_toward(velocity.y, 0, DRAG * delta)

	# Aplica el movimiento utilizando la propiedad velocity
	move_and_slide()
	
func acariciar():
	$AnimatedSprite2D.play("acariciar_1")
	await get_tree().create_timer(0.4285714286).timeout
	$AnimatedSprite2D.play("acariciar_2")
	

extends Node2D
@onready var pj = $PJ
@onready var animacionE1 = $EstrofaAnim/AnimationPlayer
@onready var animacionE2 = $EstrofaAnim2/AnimationPlayer


#variables de cosas del control de cámara
@onready var camera = $Camera2D
var camera_follows = false #si la cámara está siguiendo al jugador
var x_movement = true #si el movimiento es horizontal
var target_threshold = 0
var room = 0;

# Contador de decisiones
var cont_decision = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	ScriptGlobal.nivel = self
	ScriptGlobal.nodo_musica = $AudioStreamPlayer
	ScriptGlobal.cont_decision = cont_decision
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		begin_game()
	
	if camera_follows:
		if x_movement:
			if camera.position.x < pj.position.x+300:
				camera.position.x = pj.position.x+300
			if camera.position.x >= target_threshold:
				next_room()
		else:
			if camera.position.y > pj.position.y-200:
				camera.position.y = pj.position.y-200
			if camera.position.y <= target_threshold:
				next_room()
func _input(event):
	pass
		
func begin_game():
	#Animación de cámara para enfocar la sala 1
	var tween = get_tree().create_tween()

	tween.tween_property(
		camera,                  # Nodo objetivo
		"position",             # Propiedad a interpolar
		Vector2(722.5,405),         # Valor final
		1         # Duración
	).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	
	var tween1 = get_tree().create_tween()

	tween1.tween_property(
		camera,                  # Nodo objetivo
		"zoom",             # Propiedad a interpolar
		Vector2(1,1),         # Valor final
		1         # Duración
	).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)

func activar_animacion():
	#Esto lo tendría que llamar el objeto al elegir una de las opciones
	pj.can_move = false
	animacionE1.play("estrofa")
	print("He hecho play")
	
	await get_tree().create_timer(10).timeout  #espera a que termine la estrofa
	pj.can_move = true

	begin_game_1()

	#tween.connect("finished",Callable(self,"begin_game_1"))
	
func begin_game_1():
	#Animación de cámara para enfocar la sala 1
	camera_follows = false
	#await get_tree().create_timer(2).timeout  #ESPERAR A ELEGIR OBJETO
	var tween = get_tree().create_tween()

	tween.tween_property(
		camera,                  # Nodo objetivo
		"position",             # Propiedad a interpolar
		Vector2(max(pj.position.x+300,722.5),405),         # Valor final
		0.5         # Duración
	).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)

	tween.connect("finished",Callable(self,"enter_transition1"))
	
func next_room():
	room += 1
	if room == 1:
		room2_camera()
	elif  room == 2:
		room3_camera()
	elif  room == 3:
		room4_camera()

func enter_transition1():

	camera_follows = true
	x_movement = true
	target_threshold = 1800
	
func enter_transition2():
	camera_follows = true
	x_movement = false
	target_threshold = -200
	
func enter_transition3():
	camera_follows = true
	x_movement = false
	target_threshold = -900

func room2_camera():
	camera_follows = false
	var tween = get_tree().create_tween()

	tween.tween_property(
		camera,                  # Nodo objetivo
		"position",             # Propiedad a interpolar
		Vector2(2167.5,405),         # Valor final
		1         # Duración
	).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	
	await get_tree().create_timer(2).timeout  #ESPERAR A ELEGIR OBJETO

	#Esto lo tendría que llamar el objeto al elegir una de las opciones
	pj.can_move = false
	animacionE2.play("estrofa")
	print("He hecho play")
	
	await get_tree().create_timer(10).timeout  #espera a que termine la estrofa
	pj.can_move = true
	room2_camera_1()
	
	#tween.connect("finished",Callable(self,"room2_camera_1")) #esto es un apaño por el cambio de eje
	
func room2_camera_1():
	await get_tree().create_timer(2).timeout  #ESPERAR A ELEGIR OBJETO
	
	camera_follows = false
	var tween = get_tree().create_tween()

	tween.tween_property(
		camera,                  # Nodo objetivo
		"position",             # Propiedad a interpolar
		Vector2(2167.5,min(pj.position.y-200,405)),         # Valor final
		0.5         # Duración
	).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	
	tween.connect("finished",Callable(self,"enter_transition2")) #esto se haría al acabar la estrofa aqui

func room3_camera():
	camera_follows = false
	var tween = get_tree().create_tween()

	tween.tween_property(
		camera,                  # Nodo objetivo
		"position",             # Propiedad a interpolar
		Vector2(2167.5,-405),         # Valor final
		1         # Duración
	).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	
	tween.connect("finished",Callable(self,"room3_camera_1")) #esto se haría al acabar la estrofa aqui

func room3_camera_1():
	await get_tree().create_timer(2).timeout  #ESPERAR A ELEGIR OBJETO
	
	camera_follows = false
	var tween = get_tree().create_tween()

	tween.tween_property(
		camera,                  # Nodo objetivo
		"position",             # Propiedad a interpolar
		Vector2(2167.5,min(pj.position.y-200,-405)),         # Valor final
		0.5         # Duración
	).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	
	tween.connect("finished",Callable(self,"enter_transition3")) #esto se haría al acabar la estrofa aqui

func room4_camera():
	camera_follows = false
	var tween = get_tree().create_tween()

	tween.tween_property(
		camera,                  # Nodo objetivo
		"position",             # Propiedad a interpolar
		Vector2(2167.5,-1215),         # Valor final
		1         # Duración
	).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	
	tween.connect("finished",Callable(self,"room4_camera_1"))

func room4_camera_1():
	await get_tree().create_timer(1).timeout  #ESPERAR A ELEGIR OBJETO
	
	camera_follows = false
	var tween = get_tree().create_tween()

	tween.tween_property(
		camera,                  # Nodo objetivo
		"position",             # Propiedad a interpolar
		Vector2(1859,-1231),         # Valor final
		0.8         # Duración
	).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	
	var tween1 = get_tree().create_tween()

	tween1.tween_property(
		camera,                  # Nodo objetivo
		"zoom",             # Propiedad a interpolar
		Vector2(1/(0.803),1/(0.803)),         # Valor final
		0.5         # Duración
	).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)

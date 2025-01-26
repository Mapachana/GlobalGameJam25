extends Node2D
@onready var pj = $PJ
@onready var animacionIntro = $Titulo/AnimationPlayer

@onready var animacionE1 = $EstrofaAnim/AnimationPlayer
@onready var animacionE2 = $EstrofaAnim1/AnimationPlayer
@onready var animacionE3 = $EstrofaAnim2/AnimationPlayer
@onready var animacionE4 = $EstrofaAnim3/AnimationPlayer
@onready var animacionE5 = $EstrofaAnim4/AnimationPlayer
@onready var animacionE6 = $EstrofaAnim5/AnimationPlayer

const DURACION_ESTROFA = 44 #CAMBIAR ANTES DEL FINAL
const DURACION_MINITRANS = 1

#variables de cosas del control de cámara
@onready var camera = $Camera2D
var camera_follows = false #si la cámara está siguiendo al jugador
var x_movement = true #si el movimiento es horizontal
var target_threshold = 0
var room = 0;
var has_started = false

# Contador de decisiones
var cont_decision = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	ScriptGlobal.nivel = self
	ScriptGlobal.nodo_musica = $AudioStreamPlayer
	ScriptGlobal.cont_decision = cont_decision
	

	#ScriptGlobal.setupmusica("A")
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_accept") && not has_started:
		has_started = true
		intro_animation()
		ScriptGlobal.setupmusica("A")
		
		
	
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

func intro_animation():
	animacionIntro.play("new")
	await get_tree().create_timer(0.5).timeout  #espera a que termine la estrofa

	begin_game()

	
func begin_game():
	pj.can_move = false
	
	#Animación de cámara para enfocar la sala 1
	var tween = get_tree().create_tween()
#AQUI HAY QUE PONER EL SONIDO DE INICIO
	tween.tween_property(
		camera,                  # Nodo objetivo
		"position",             # Propiedad a interpolar
		Vector2(722.5,405),         # Valor final
		0.8         # Duración
	).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	
	var tween1 = get_tree().create_tween()

	tween1.tween_property(
		camera,                  # Nodo objetivo
		"zoom",             # Propiedad a interpolar
		Vector2(1,1),         # Valor final
		0.8         # Duración
	).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	
	#CAMBIAR ANTES DEL FINAL
	tween.connect("finished",Callable(self,"comic_anim"))
	#pj.visible=true
	#pj.can_move = true

func comic_anim():
	await get_tree().create_timer(0.6).timeout  # Espera a que termine la estrofa

	var tween1 = get_tree().create_tween()
	tween1.tween_property(
		$Comic/FondoNegro,                  # Nodo objetivo
		"modulate:a",             # Propiedad a interpolar
		1,         # Valor final
		0.2         # Duración
	).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	
	var comics = [$Comic/Comic1,$Comic/Comic2,$Comic/Comic2,$Comic/Comic3,$Comic/Comic4,$Comic/Comic5,$Comic/Comic6,$Comic/Comic7,$Comic/Comic8]
	for comic in comics:  # Itera desde 1 hasta 8
		await get_tree().create_timer(0.6).timeout  # Espera a que termine la estrofa
		var tween2 = get_tree().create_tween()
		tween2.tween_property(
			comic,       # Nodo objetivo dinámico
			"modulate:a",            # Propiedad a interpolar
			1,                       # Valor final
			0.4                      # Duración
		).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	
	pj.visible=true
	pj.can_move = true
	
	await get_tree().create_timer(2.8).timeout  #espera a que termine la estrofa
	var tween3 = get_tree().create_tween()
	tween3.tween_property(
		$Comic,                  # Nodo objetivo
		"modulate:a",             # Propiedad a interpolar
		0,         # Valor final
		0.2         # Duración
	).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	

func activar_animacion(numero):
	#Esto lo tendría que llamar el objeto al elegir una de las opciones
	pj.can_move = false
		
	print(numero)
	
	# TODO ampliar a todas las estrofas
	match numero:
		1:
			await get_tree().create_timer(DURACION_MINITRANS).timeout
			animacionE1.play("estrofa")
			$Obj1.desaparecer()
			$Obj2.desaparecer()
			#$Salon/humo.queue_free()
			await get_tree().create_timer(DURACION_ESTROFA).timeout  #espera a que termine la estrofa
			pj.can_move = true
			begin_game_1()
			print("He hecho play de 1")
		2:
			animacionE2.play("estrofa")
			$Obj1.desaparecer()
			$Obj2.desaparecer()
			$Salon/humo.queue_free()
			print("He hecho play de 2")
			await get_tree().create_timer(DURACION_ESTROFA).timeout  #espera a que termine la estrofa
			pj.can_move = true
			begin_game_1()
		3:
			$Obj3.desaparecer()
			$Obj4.desaparecer()
			animacionE3.play("estrofa")
			print("He hecho play de 3")
			await get_tree().create_timer(DURACION_ESTROFA).timeout  #espera a que termine la estrofa
			pj.can_move = true
			room2_camera_1()
		4:
			$Obj3.desaparecer()
			$Obj4.desaparecer()
			animacionE4.play("estrofa")
			print("He hecho play de 4")
			await get_tree().create_timer(DURACION_ESTROFA).timeout  #espera a que termine la estrofa
			pj.can_move = true
			room2_camera_1()
		5:			
			$Obj5.desaparecer()
			$Obj6.desaparecer()
			animacionE5.play("estrofa")
			print("He hecho play de 5")
			await get_tree().create_timer(DURACION_ESTROFA).timeout  #espera a que termine la estrofa
			pj.can_move = true
			room3_camera_1()
		6:
			$Obj5.desaparecer()
			$Obj6.desaparecer()
			animacionE6.play("estrofa")
			print("He hecho play de 6")
			await get_tree().create_timer(DURACION_ESTROFA).timeout  #espera a que termine la estrofa
			pj.can_move = true
			room3_camera_1()
			
	#print("He hecho play de")
	


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
	$collisions/muro1.disabled = true
	
func enter_transition2():
	print("entre en transicion2")

	camera_follows = true
	x_movement = false
	target_threshold = -200
	$collisions/muro2.disabled = true
	
func enter_transition3():
	print("entre en transicion3")
	camera_follows = true
	x_movement = false
	target_threshold = -900
	$collisions/muro3.disabled = true


func room2_camera():
	camera_follows = false
	$collisions/muro1.disabled = false

	var tween = get_tree().create_tween()
	
	tween.tween_property(
		camera,                  # Nodo objetivo
		"position",             # Propiedad a interpolar
		Vector2(2167.5,405),         # Valor final
		1         # Duración
	).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	
		
	
	#Esto lo tendría que llamar el objeto al elegir una de las opciones
	#pj.can_move = false
	#animacionE2.play("estrofa")
	#print("He hecho play")
		
	#tween.connect("finished",Callable(self,"room2_camera_1")) #esto es un apaño por el cambio de eje
	
func room2_camera_1():
	#await get_tree().create_timer(2).timeout  #ESPERAR A ELEGIR OBJETO
	
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
	print("room3_camera")
	camera_follows = false
	$collisions/muro2.disabled = false
	var tween = get_tree().create_tween()

	tween.tween_property(
		camera,                  # Nodo objetivo
		"position",             # Propiedad a interpolar
		Vector2(2167.5,-405),         # Valor final
		1         # Duración
	).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	
	#tween.connect("finished",Callable(self,"room3_camera_1")) #esto se haría al acabar la estrofa aqui

func room3_camera_1():
	#await get_tree().create_timer(2).timeout  #ESPERAR A ELEGIR OBJETO
	print("room3_camera_1")
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
	
	tween.connect("finished",Callable(self,"decision_final"))
	#METER ANIM DEL FINAL DEL JUEGO
func decision_final():
	ScriptGlobal.musica_final()
	if cont_decision<0:
		print("final a")
		#$Finales.play("FinalA")
		$EstrofaAnim6/AnimationPlayer.play("estrofa")
		await get_tree().create_timer(39).timeout  #espera a que termine la estrofa
		ScriptGlobal.goto_scene("res://Scenes/mainmenu.tscn")
		
	else:
		print("final b")
		#$Finales.play("FinalB")
		$EstrofaAnim7/AnimationPlayer.play("estrofa")
		await get_tree().create_timer(39).timeout  #espera a que termine la estrofa
		ScriptGlobal.goto_scene("res://Scenes/mainmenu.tscn")
	#tween.connect("finished",Callable(self,"room4_camera_1"))

func room4_camera_1():
	#await get_tree().create_timer(1).timeout  #ESPERAR A ELEGIR OBJETO
	print("room camera 4")
	$collisions/muro3.disabled = false

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


func _on_finales_animation_finished(anim_name: StringName) -> void:
	await get_tree().create_timer(39).timeout  #espera a que termine la estrofa
	ScriptGlobal.goto_scene("res://Scenes/mainmenu.tscn")
	pass # Replace with function body.

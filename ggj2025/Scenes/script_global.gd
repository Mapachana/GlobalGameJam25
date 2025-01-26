extends Node

# Nodo musica del nivel
var nodo_musica = null

# Contador de decisiones del nivel
var cont_decision = null

# Nivel en si
var nivel

var ultima_decision = 0

var current_scene = null
 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var root = get_tree().root
	current_scene = root.get_child(root.get_child_count() - 1)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func activar_animacion(anim):
	print(anim)
	nivel.activar_animacion(anim)
	pass
	
func setupmusica(eleccion):
	var ruta = "res://Music/desesperacion/"
	var fichero_quedarse = "A definitivo.mp3"
	var fichero_irse = "B definitivo.mp3"
	var pos = 0
	
	if eleccion == "C":
		print("WTF")
	
	print("SETUPMUSICA")
	
	match ultima_decision:
		0:
			if eleccion == "A":
				pos = 0
			else:
				pos = 0
			nodo_musica.stream = load(ruta+fichero_quedarse)

		1:
			if eleccion == "A":
				pos = 56
				nodo_musica.stream = load(ruta+fichero_quedarse)

			else:
				pos = 0
				nodo_musica.stream = load(ruta+fichero_irse)

		2:
			if eleccion == "A":
				pos = 156
				nodo_musica.stream = load(ruta+fichero_quedarse)

			else:
				pos = 100
				nodo_musica.stream = load(ruta+fichero_irse)
		3:
			if eleccion == "A":
				pos = 256
				nodo_musica.stream = load(ruta+fichero_quedarse)

			else:
				pos = 200
				nodo_musica.stream = load(ruta+fichero_irse)
			
	
	print("DECISION")
	print(ultima_decision)
	
	nodo_musica.play(pos)
	#nodo_musica.seek(5.0)
	
	ultima_decision += 1
	print("dec")
	print(ultima_decision)


func musica_final():
	var ruta = "res://Music/desesperacion/"
	var fichero_quedarse = "Final A quedarse.mp3"
	var fichero_irse = "Final B irse.mp3"
	if cont_decision > 0:
		nodo_musica.stream = load(ruta+fichero_quedarse)
	else:
		nodo_musica.stream = load(ruta+fichero_irse)
	
	nodo_musica.play()

	
func acariciar_gato():
	print("GLOBAL ACARICIA A GATO")
	# Hacer animacion de acariciar al gato y bloquear el personaje
	#nivel.PJ.play("acariciar")
	
func goto_scene(path):
	# This function will usually be called from a signal callback,
	# or some other function in the current scene.
	# Deleting the current scene at this point is
	# a bad idea, because it may still be executing code.
	# This will result in a crash or unexpected behavior.

	# The solution is to defer the load to a later time, when
	# we can be sure that no code from the current scene is running:

	call_deferred("_deferred_goto_scene", path)


func _deferred_goto_scene(path):
	# It is now safe to remove the current scene.
	current_scene.free()

	# Load the new scene.
	var s = ResourceLoader.load(path)

	# Instance the new scene.
	current_scene = s.instantiate()

	# Add it to the active scene, as child of root.
	get_tree().root.add_child(current_scene)

	# Optionally, to make it compatible with the SceneTree.change_scene_to_file() API.
	get_tree().current_scene = current_scene

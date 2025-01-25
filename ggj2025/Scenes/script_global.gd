extends Node

# Nodo musica del nivel
var nodo_musica = null
var nodo_ambiente = null
var nodo_ambiente2 = null

# Contador de decisiones del nivel
var cont_decision = null

# Nivel en si
var nivel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func activar_animacion(anim):
	print(anim)
	nivel.activar_animacion(anim)
	pass
	
func setupmusica():
	nodo_musica.stream = load("res://Music/prueba/"+"GGJ2024.ogg")
	nodo_musica.play()
	
func acariciar_gato():
	print("GLOBAL ACARICIA A GATO")
	# Hacer animacion de acariciar al gato y bloquear el personaje
	#nivel.PJ.play("acariciar")

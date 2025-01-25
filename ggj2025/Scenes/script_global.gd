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
	
func setupmusica(base, melodia1, melodia2, hay_melodia2):
	var ruta = "res://Music/fondo_fx/"
	
	nodo_musica.stream = load(ruta+base)
	nodo_musica.play()
	
	nodo_ambiente.stream = load(ruta+melodia1)
	nodo_ambiente.play()
	
	if hay_melodia2:
		nodo_ambiente2.stream = load(ruta+melodia2)
		nodo_ambiente2.play()
	
func acariciar_gato():
	print("GLOBAL ACARICIA A GATO")
	# Hacer animacion de acariciar al gato y bloquear el personaje
	#nivel.PJ.play("acariciar")

extends Node

# Nodo musica del nivel
var nodo_musica = null
var nodo_ambiente = null
var nodo_ambiente2 = null

# Contador de decisiones del nivel
var cont_decision = null

# Nivel en si
var nivel

var ultima_decision = 0

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
	var ruta = "res://Music/fondo_fx/"
	var base = ""
	var melodia1 = ""
	var melodia2 = ""
	var hay_melodia1 = false
	var hay_melodia2 = false
	
	match ultima_decision:
		0:
			base = "Ambiente 1 (no-FX).wav"
			melodia1 = "Ghost (no-FX).wav"
			hay_melodia1 = true
		1:
			base = "Ambiente 2 (no-FX).wav"
			melodia1 = "Ghost (no-FX).wav"
			melodia2 = "Pizzicato (no-FX).wav"
			hay_melodia1 = true
			hay_melodia2 = true
		2:
			base = "Ambiente 3 (no-FX).wav"
			melodia1 = "Ghost (no-FX).wav"
			melodia2 = "Music Box (no-FX).wav"
			hay_melodia1 = true
			hay_melodia2 = true
		3:
			base = "Ambiente 3 (no-FX).wav"
			
	
	print("DECISION")
	print(ultima_decision)
	
	nodo_musica.stream = load(ruta+base)
	nodo_musica.play()
	
	if hay_melodia1:
		nodo_ambiente.stream = load(ruta+melodia1)
		nodo_ambiente.play()
	
	if hay_melodia2:
		nodo_ambiente2.stream = load(ruta+melodia2)
		nodo_ambiente2.play()
	
func acariciar_gato():
	print("GLOBAL ACARICIA A GATO")
	# Hacer animacion de acariciar al gato y bloquear el personaje
	#nivel.PJ.play("acariciar")

extends Node

# Nodo musica del nivel
var nodo_musica = null

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

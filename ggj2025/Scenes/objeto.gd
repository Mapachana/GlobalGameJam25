extends Area2D

var perso_en_area = null

# Tipo de objeto, si es para quedarse o irse
enum TIPO { QUEDARSE, IRSE }
@export var tipo: TIPO

# Cancion a reproducir durante el recuerdo, HAY QUE INCLUIR .MP3 AL FINAL
@export var cancion: String
# ruta a los efectos
var ruta = "res://Music/prueba/"

# Animacion que va a reproducir durante el recuerpo, va de 1 a 6
@export var anim: int


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	perso_en_area = false
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Si el personaje esta en el area del objeto y pulsa paro la musica y reproduzco el trozo de cancion y efectos
	# TODO cambiar boton a pulsar
	if perso_en_area and Input.is_action_just_pressed("ui_down"):
		# Parar musica y reproducir efectos de sonido
		$Sprite2D.hide()
		$CollisionShape2D.queue_free()
		ScriptGlobal.nodo_musica.stop()
		$AudioStreamPlayer.play()
		
		# Activar animacion
		ScriptGlobal.activar_animacion(anim)
		
		# Modificar contador de decisiones
		if tipo == TIPO.QUEDARSE:
			ScriptGlobal.cont_decision += 1
		else:
			ScriptGlobal.cont_decision -= 1
			
		
	
	# Si pulso el botón cambia que sonido reproduce. Esto luego se cambia a si tomo una decision u otra
	if Input.is_action_just_pressed("ui_accept") and not $AudioStreamPlayer.playing:		
		var recurso = ruta+cancion
		$AudioStreamPlayer.stream.set_list_stream(1, load(recurso))
	
	pass


# Si esta en el area:
func _on_body_entered(body: Node2D) -> void:
	perso_en_area = true

	pass 
	



# Una vez ha terminado la cancion y efectos pongo la musica desde el principio
func _on_audio_stream_player_finished() -> void:
	ScriptGlobal.nodo_musica.play()
	queue_free()
	pass # Replace with function body.




func _on_body_exited(body: Node2D) -> void:
	perso_en_area = false
	pass # Replace with function body.

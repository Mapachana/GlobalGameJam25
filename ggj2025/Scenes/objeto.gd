extends Area2D

var perso_en_area = null

# Tipo de objeto, si es para quedarse o irse
enum TIPO { QUEDARSE, IRSE }
@export var tipo: TIPO
@export var imagen: Texture2D
@export var otro: Node2D

# Cancion a reproducir durante el recuerdo, HAY QUE INCLUIR .MP3 AL FINAL
@export var cancion: String
# ruta a los efectos
var ruta = "res://Music/prueba/"

# Animacion que va a reproducir durante el recuerpo, va de 1 a 6
@export var anim: int
@onready var sprite = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	perso_en_area = false
	$Sprite2D.texture = imagen #lo que haya metido de var
	if $AnimatedSprite2D:
		sprite = $AnimatedSprite2D
	else:
		sprite = $Sprite2D
	
	sprite.material.set_shader_parameter("aura_color", Color(1, 1.0, 1.0, 1.0));

	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Si el personaje esta en el area del objeto y pulsa paro la musica y reproduzco el trozo de cancion y efectos
	# TODO cambiar boton a pulsar
	if perso_en_area and Input.is_action_just_pressed("ui_accept"):
		# Parar musica y reproducir efectos de sonido
		#$Sprite2D.hide()
		perso_en_area = false
		
		ScriptGlobal.nodo_musica.stop()
		ScriptGlobal.nodo_ambiente.stop()
		ScriptGlobal.nodo_ambiente2.stop()
		$AudioStreamPlayer.play()
		
		var tween = get_tree().create_tween()
		tween.tween_property(
			self,                  # Nodo objetivo
			"scale",             # Propiedad a interpolar
			Vector2(1.15,1.15),         # Valor final
			0.3         # Duración
		).set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_IN_OUT)
		
		# Activar animacion
		ScriptGlobal.activar_animacion(anim)
		
		# Modificar contador de decisiones
		if tipo == TIPO.QUEDARSE:
			ScriptGlobal.cont_decision += 1
		else:
			ScriptGlobal.cont_decision -= 1
			
		print(anim)
		
	
	# Si pulso el botón cambia que sonido reproduce. Esto luego se cambia a si tomo una decision u otra
	#if Input.is_action_just_pressed("ui_accept") and not $AudioStreamPlayer.playing:		
		#var recurso = ruta+cancion
		#$AudioStreamPlayer.stream.set_list_stream(1, load(recurso))
	
	pass


# Si esta en el area:
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("pj"):
		perso_en_area = true

		var tween = get_tree().create_tween()

		tween.tween_property(
			self,                  # Nodo objetivo
			"scale",             # Propiedad a interpolar
			Vector2(1.15,1.15),         # Valor final
			0.3         # Duración
		).set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_IN_OUT)
		sprite.material.set_shader_parameter("aura_width", 4);
		sprite.material.set_shader_parameter("aura_color", Color(0.373, 0.808, 0.82, 1.0));
	
	pass 
	



# Una vez ha terminado la cancion y efectos pongo la musica desde el principio
func _on_audio_stream_player_finished() -> void:
	# Cambiar el stream de cada uno segun las decisiones
	ScriptGlobal.setupmusica("Ambiente 1 (no-FX).wav", "Ghost (no-FX).wav", "", false)
	queue_free()
	pass # Replace with function body.

func cargar_recurso(rec) -> AudioStream:
	var recurso = ruta+cancion
	return load(recurso)


func desaparecer():	
	await get_tree().create_timer(0.6).timeout
	$Sprite2D.hide()
	if $AnimatedSprite2D :
		$AnimatedSprite2D.hide()
	$CollisionShape2D.queue_free()
	#queue_free()


func _on_body_exited(body: Node2D) -> void:
	perso_en_area = false

	var tween = get_tree().create_tween()

	tween.tween_property(
		self,                  # Nodo objetivo
		"scale",             # Propiedad a interpolar
		Vector2(1,1),         # Valor final
		0.3        # Duración
	).set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_IN_OUT)
	
	sprite.material.set_shader_parameter("aura_width", 2.5);
	sprite.material.set_shader_parameter("aura_color", Color(1, 1, 1, 1));

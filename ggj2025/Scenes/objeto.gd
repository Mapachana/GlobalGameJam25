extends Area2D

var perso_en_area = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	perso_en_area = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Si el personaje esta en el area del objeto y pulsa paro la musica y reproduzco el trozo de cancion y efectos
	# TODO cambiar boton a pulsar
	if perso_en_area and Input.is_action_just_pressed("ui_down"):
		$Sprite2D.hide()
		$CollisionShape2D.queue_free()
		ScriptGlobal.nodo_musica.stop()
		$AudioStreamPlayer.play()
	
	# Si pulso el botón cambia que sonido reproduce. Esto luego se cambia a si tomo una decision u otra
	if Input.is_action_just_pressed("ui_accept") and not $AudioStreamPlayer.playing:		
		$AudioStreamPlayer.stream.set_list_stream(1, load("res://Music/prueba/explotar.mp3"))
	
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

extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	# Si pulso el botón cambia que sonido reproduce. Esto luego se cambia a si tomo una decision u otra
	if Input.is_action_just_pressed("ui_accept") and not $AudioStreamPlayer.playing:		
		$AudioStreamPlayer.stream.set_list_stream(1, load("res://Music/prueba/explotar.mp3"))
	
	pass


# Si el personaje elige este objeto paro la musica y reproduzco el trozo de cancion y efectos
func _on_body_entered(body: Node2D) -> void:
	$Sprite2D.hide()
	$CollisionShape2D.queue_free()
	ScriptGlobal.nodo_musica.stop()
	$AudioStreamPlayer.play()
	pass # Replace with function body.


# Una vez ha terminado la cancion y efectos pongo la musica desde el principio
func _on_audio_stream_player_finished() -> void:
	ScriptGlobal.nodo_musica.play()
	queue_free()
	pass # Replace with function body.

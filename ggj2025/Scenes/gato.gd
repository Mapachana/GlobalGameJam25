extends Area2D

var animacion_actual = null

var acariciable = false

var andando = false # TODO cambiar segun este andando o no

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animacion_actual = "quieto"
	change_anim("quieto")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if not andando and acariciable and Input.is_action_pressed("ui_accept"):
		change_anim("quieto")
		print("ACARICIANDO AL GATO MIAU MIAU")
		ScriptGlobal.acariciar_gato()
	pass


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("pj"):
		print("acariciable")
		acariciable = true	
	pass # Replace with function body.

func change_anim(animacion):
	if animacion != animacion_actual:
		$Sprite2D/AnimationPlayer.play(animacion)


func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("pj"):
		acariciable = false
	pass # Replace with function body.

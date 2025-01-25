extends Area2D

var animacion_actual = null

var acariciable = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animacion_actual = "andar"
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if acariciable and Input.is_action_pressed("ui_accept"):
		print("ACARICIANDO AL GATO MIAU MIAU")
	pass


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("pj"):
		print("acariciable")
		acariciable = true
		# change_anim("quieto")	
	pass # Replace with function body.

func change_anim(animacion):
	if animacion != animacion_actual:
		$Sprite2D/AnimationPlayer.play(animacion)


func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("pj"):
		acariciable = false
	pass # Replace with function body.

extends Area2D

var animacion_actual = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animacion_actual = "andar"
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("pj") and Input.is_action_pressed("ui_accept"):
		print("Acaricio al gatito miau")
		# change_anim("acariciar")	
	pass # Replace with function body.

func change_anim(animacion):
	if animacion != animacion_actual:
		$Sprite2D/AnimationPlayer.play(animacion)

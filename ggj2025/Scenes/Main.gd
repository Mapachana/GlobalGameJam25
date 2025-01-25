extends Node2D

@onready var camera = $Camera2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		begin_game()
	
	
func _input(event):
	pass
		
func begin_game():
	#Animación de cámara para enfocar la sala 1
	var tween = get_tree().create_tween()

	tween.tween_property(
		camera,                  # Nodo objetivo
		"position",             # Propiedad a interpolar
		Vector2(722.5,405),         # Valor final
		1         # Duración
	).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	
	var tween1 = get_tree().create_tween()

	tween1.tween_property(
		camera,                  # Nodo objetivo
		"zoom",             # Propiedad a interpolar
		Vector2(1,1),         # Valor final
		1         # Duración
	).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	

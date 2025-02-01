extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func acariciar():
	$AnimatedSprite2D.play("pet")

func idle():
	$AnimatedSprite2D.play("idle")
	
func walk():
	$AnimatedSprite2D.play("Move")

extends Node2D


# Called when the node enters the scene tree for the first time.

func _ready():
	ScriptGlobal.nodo_musica = $AudioStreamPlayer
	print(ScriptGlobal.nodo_musica)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

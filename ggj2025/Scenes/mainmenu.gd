extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_start_pressed() -> void:
	#ScriptGlobal.current_scene.queue_free()
	ScriptGlobal.reset_var()
	ScriptGlobal.goto_scene("res://Scenes/Main.tscn")
	pass # Replace with function body.

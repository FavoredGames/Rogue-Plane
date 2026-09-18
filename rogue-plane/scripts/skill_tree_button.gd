extends Button





# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# Emits signal when pressed, so that the game manager can load the skill tree
func _on_pressed() -> void:
	SignalManager.load_skill_tree.emit()
	

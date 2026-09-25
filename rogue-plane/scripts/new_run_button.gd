extends Button

# Emits signal when pressed, so that the game manager can load the main scene.
func _on_pressed() -> void:
	SignalManager.load_game.emit()
	

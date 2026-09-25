extends Button


# Emits signal when pressed, so that the game manager can load the skill tree.
func _on_pressed() -> void:
	SignalManager.load_skill_tree.emit()

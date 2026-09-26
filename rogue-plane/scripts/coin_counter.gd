extends Control

# Signal so it knows when the skill tree is displayed.
func _ready() -> void:
	SignalManager.load_skill_tree.connect(_show_coin_counter)


# When skill tree is on screen the total coin counter is shown
func _show_coin_counter():
	show()


# Hides coin counter during boss so doesn't effect boss health bar visibility.
func _on_boss_timer_timeout() -> void:
	hide()

extends Control

# Connects to siganl so it can no when player has died.
func _ready() -> void:
	SignalManager.player_died.connect(_remove_boss_health_bar)


# Used to romove the health bar when player has died as part of recieving the signal.
func _remove_boss_health_bar():
	queue_free()

extends Control


func _ready() -> void:
	SignalManager.player_died.connect(_remove_boss_health_bar)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


# Used to romove the health bar when player has died as part of recieving the signal.
func _remove_boss_health_bar():
	queue_free()

# Not used in game code.
extends Area2D

const SPEED: int = 200


# Moves the bosses bullets down the screen.
func _process(delta: float) -> void:
	move_local_x(SPEED * delta)

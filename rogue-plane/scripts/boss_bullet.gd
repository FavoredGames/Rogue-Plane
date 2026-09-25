# Not used in game code.
extends Area2D

const SPEED: int = 200

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Moves the bosses bullets down the screen.
func _process(delta: float) -> void:
	move_local_x(SPEED * delta)

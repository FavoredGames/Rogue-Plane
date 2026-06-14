extends Area2D


@export var speed: float = 300.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	move_local_y(speed * delta)

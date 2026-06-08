extends Area2D

var speed: float = 800.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	move_local_y(-speed * delta)

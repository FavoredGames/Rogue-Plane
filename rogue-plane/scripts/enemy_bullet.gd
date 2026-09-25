extends Area2D

var SPEED: float = 700.0

# Moves the enemt bullet down the screen.
func _process(delta: float) -> void:
	move_local_y(SPEED * delta)


# Delets the bullet because after this timer it will be offscreen.
# This is to remove the lag caused by bullets rendered offscreen.
func _on_timer_timeout() -> void:
	queue_free()

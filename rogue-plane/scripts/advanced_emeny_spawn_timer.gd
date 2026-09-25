extends Timer

var decrease_timer: int = 0

const WHEN_TO_DECREASE_TIMER: int = 10
const TIMER_NEW_TIME_PERCENTAGE: int = 0.95


# Decreases the spawn timer after 10 homing missile enemies have spawned.
func _on_timeout() -> void:
	decrease_timer += 1
	if decrease_timer == WHEN_TO_DECREASE_TIMER:
		wait_time *= TIMER_NEW_TIME_PERCENTAGE

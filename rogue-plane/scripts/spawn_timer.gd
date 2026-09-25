extends Timer

var decrease_timer: int = 0
const WHEN_TO_DECREASE_TIMER: int = 10
var decrease_spawn_timer_percent: float = 0.95

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Reduces the spawn timer for enemy after 10 have spawned.
func _on_timeout() -> void:
	decrease_timer += 1
	if decrease_timer == WHEN_TO_DECREASE_TIMER:
		wait_time *= decrease_spawn_timer_percent

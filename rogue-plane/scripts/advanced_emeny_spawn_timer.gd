extends Timer

var decrease_timer: int = 0
var when_to_decrease_timer: int = 10

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_timeout() -> void:
	decrease_timer += 1
	if decrease_timer == when_to_decrease_timer:
		wait_time *= 0.95
		print("timert9ime", wait_time)

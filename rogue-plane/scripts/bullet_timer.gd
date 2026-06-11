extends Timer

var timer_wait_time: float = 0.25


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalManager.increase_attack_speed.connect(increase_attack_speed)


func increase_attack_speed():
	timer_wait_time -= 0.0125
	set_wait_time(timer_wait_time)
	print(timer_wait_time)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

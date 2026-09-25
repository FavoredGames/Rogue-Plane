extends Timer

var timer_wait_time: float = 0.25
const ATTACK_SPEED_REDUCTION_VALUE: float = 0.0125

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalManager.increase_attack_speed.connect(_increase_attack_speed)


# Decreases timer for shoopting to decrease player's attack speed 
# for when it gets attack speed upgrade.
func _increase_attack_speed():
	timer_wait_time -= ATTACK_SPEED_REDUCTION_VALUE
	set_wait_time(timer_wait_time)
	print(timer_wait_time)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

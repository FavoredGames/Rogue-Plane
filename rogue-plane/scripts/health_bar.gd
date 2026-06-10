extends ProgressBar

@export var player: CharacterBody2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalManager.take_damage.connect(take_damage)
	take_damage()
	SignalManager.increase_max_health.connect(increase_max_health)


func increase_max_health():
	update_health_bar()


func take_damage():
	update_health_bar()


func update_health_bar():
	value = player.health * 100 / player.max_health


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	update_health_bar()

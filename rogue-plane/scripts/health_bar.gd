extends ProgressBar

@export var player: CharacterBody2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalManager.take_damage.connect(take_damage)
	take_damage()

func take_damage():
	value = player.health * 100 / player.max_health



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

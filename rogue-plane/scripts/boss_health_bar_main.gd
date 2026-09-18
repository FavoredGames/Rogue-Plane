extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalManager.player_died.connect(remove_boss_health_bar)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func remove_boss_health_bar():
	queue_free()

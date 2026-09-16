extends Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalManager.load_skill_tree.connect(show_coin_counter)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func show_coin_counter():
	show()


func _on_boss_timer_timeout() -> void:
	hide()

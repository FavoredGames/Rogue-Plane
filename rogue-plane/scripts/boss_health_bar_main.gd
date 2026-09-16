extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalManager.player_died.connect(remove_boss_health_bar)
	SignalManager.start_phase_2.connect(hide_for_phase_2)
	SignalManager.start_phase_3.connect(hide_for_phase_3)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func hide_for_phase_2():
	hide()
	await get_tree().create_timer(1.0).timeout
	show()


func hide_for_phase_3():
	hide()
	await get_tree().create_timer(6.0).timeout
	show()

func remove_boss_health_bar():
	queue_free()

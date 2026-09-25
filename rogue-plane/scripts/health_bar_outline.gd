extends TextureRect


# Signals connected to hide health bar when boss phase cards are visible
# or when boss dies.
func _ready() -> void:
	SignalManager.player_died.connect(_remove_boss_health_bar)
	SignalManager.start_phase_2.connect(_hide_for_phase_2)
	SignalManager.start_phase_3.connect(_hide_for_phase_3)


# Hides the health bar for outline for when phase 2 card is on screen.
func _hide_for_phase_2():
	hide()
	await get_tree().create_timer(1.0).timeout
	show()

# Hides the health bar for outline for when phase 3 card
# and blindness card is on screen.
func _hide_for_phase_3():
	hide()
	await get_tree().create_timer(6.0).timeout
	show()


# Used to remove the health bar when player dies becasue the scene will change.
func _remove_boss_health_bar():
	queue_free()

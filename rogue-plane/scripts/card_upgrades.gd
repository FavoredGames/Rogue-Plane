extends Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalManager.card_upgrades.connect(show_upgrade_cards)
	


func show_upgrade_cards():
	visible = true
	get_tree().paused = true


func _on_health_increase_card_pressed() -> void:
	SignalManager.increase_max_health_temporary.emit()
	unpause()


func _on_damage_increase_card_pressed() -> void:
	SignalManager.increase_damage.emit()
	unpause()


func _on_increase_attack_speed_pressed() -> void:
	SignalManager.increase_attack_speed.emit()
	unpause()


func unpause():
	visible = false
	SignalManager.reset_xp.emit()
	get_tree().paused = false

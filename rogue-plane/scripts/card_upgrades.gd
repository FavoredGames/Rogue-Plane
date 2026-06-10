extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalManager.card_upgrades.connect(show_upgrade_cards)


func show_upgrade_cards():
	visible = true
	get_tree().paused


func _on_health_increase_card_pressed() -> void:
	print("buttonpressed")
	SignalManager.increase_max_health.emit()
	

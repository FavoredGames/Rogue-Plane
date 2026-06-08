extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalManager.card_upgrades.connect(show_upgrade_cards)


func show_upgrade_cards():
	visible = true
	get_tree().paused


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

extends Button

@export var coin_label: Label

const BASE_TEXT: String = "+3 MAX HP
	COST:"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_update_cost()


# Makes sure player has sufficent funds to purchase upgrade and if so takes the 
# coins away from the total coins and updates the coin label.
func _on_pressed() -> void:
	if GameManager.coins_from_run >= GameManager.max_hp_cost:
		GameManager.coins_from_run -= GameManager.max_hp_cost
		coin_label.update_coins()
		SignalManager.increase_max_health_permanent.emit()
		SignalManager.update_total_coins.emit()
		_update_cost()


# Displays the updated cost.
func _update_cost():
	text = BASE_TEXT + str(GameManager.max_hp_cost)

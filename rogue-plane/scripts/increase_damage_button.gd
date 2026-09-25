extends Button

@export var coin_label: Label

const BASE_TEXT: String = "+1 DAMAGE
	COST:"


func _ready() -> void:
	# Makes cost up to date immediately.
	_update_cost()
	# Button is disabled if max hp upgrade has never been purchased.
	if GameManager.damage_button_disabled == true:
		disabled = true
	# Button is enabled if max hp upgrade has never been purchased.
	else:
		disabled = false
	SignalManager.increase_max_health_permanent.connect(_enable)


# Enables damage button in max hp has been purchased before.
func _enable():
	GameManager.damage_button_disabled = false
	disabled = false


# Makes sure player has sufficent funds to purchase upgrade and if so takes the 
# coins away from the total coins and updates the coin label.
func _on_pressed() -> void:
	if GameManager.coins_from_run >= GameManager.damage_cost:
		GameManager.coins_from_run -= GameManager.damage_cost
		coin_label.update_coins()
		SignalManager.increase_damage_permanent.emit()
		SignalManager.update_total_coins.emit()
		_update_cost()
	else:
		print("insufficient funds :(")


# Displays the updated cost.
func _update_cost():
	text = BASE_TEXT + str(GameManager.damage_cost)

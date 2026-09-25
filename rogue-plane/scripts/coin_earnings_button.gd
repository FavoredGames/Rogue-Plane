extends Button

@export var coin_label: Label

const BASE_TEXT: String = "+10% CHANCE 
	x2 COINS
	COST:"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_update_cost()
	if GameManager.damage_button_disabled == true:
		disabled = true
	else:
		disabled = false
	SignalManager.increase_max_health_permanent.connect(_enable)


# Enables the button when health upgrade has been purchased. 
# To create the skill tree feel.
func _enable():
	GameManager.damage_button_disabled = false
	disabled = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


# Checks player has enough coins for transaction.
# If they do takes the coins, apllies the upgrade and increases cost.
# Done through signals in other scripts.
func _on_pressed() -> void:
	if GameManager.coins_from_run >= GameManager.extra_coin_upgrade_cost:
		GameManager.coins_from_run -= GameManager.extra_coin_upgrade_cost
		coin_label.update_coins()
		SignalManager.increase_extra_coin_chance.emit()
		SignalManager.update_total_coins.emit()
		_update_cost()


# Updates the cost to the newly set npot cost.
func _update_cost():
	text = BASE_TEXT + str(GameManager.extra_coin_upgrade_cost)

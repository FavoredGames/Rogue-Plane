extends Button

@export var coin_label: Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_cost()
	if GameManager.damage_button_disabled == true:
		disabled = true
	else:
		disabled = false
	SignalManager.increase_max_health_permanent.connect(enable)


func enable():
	GameManager.damage_button_disabled = false
	disabled = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_pressed() -> void:
	if GameManager.coins_from_run >= GameManager.extra_coin_upgrade_cost:
		GameManager.coins_from_run -= GameManager.extra_coin_upgrade_cost
		coin_label.update_coins()
		SignalManager.increase_extra_coin_chance.emit()
		SignalManager.update_total_coins.emit()
		update_cost()
	else:
		print("insufficient funds :(")


func update_cost():
	text = "+10% CHANCE 
	x2 COINS
	COST:" + str(GameManager.extra_coin_upgrade_cost)

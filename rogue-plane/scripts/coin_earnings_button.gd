extends Button

@export var coin_label: Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	text = "Increase coins. Cost:" + str(GameManager.extra_coin_upgrade_cost)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_pressed() -> void:
	if GameManager.coins_from_run >= GameManager.extra_coin_upgrade_cost:
		GameManager.coins_from_run -= GameManager.extra_coin_upgrade_cost
		coin_label.update_coins()
		SignalManager.increase_extra_coin_chance.emit()
		SignalManager.update_total_coins.emit()
		text = "Increase coins. Cost:" + str(GameManager.extra_coin_upgrade_cost)
	else:
		print("insufficient funds :(")

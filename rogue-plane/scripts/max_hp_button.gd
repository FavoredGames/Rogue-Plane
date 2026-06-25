extends Button

@export var coin_label: Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	text = "increase max hp. cost:" + str(GameManager.max_hp_cost)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_pressed() -> void:
	if GameManager.coins_from_run >= GameManager.max_hp_cost:
		GameManager.coins_from_run -= GameManager.max_hp_cost
		coin_label.update_coins()
		SignalManager.update_max_hp_upgrade.emit()
		SignalManager.update_total_coins.emit()
		print(GameManager.coins_from_run)
		text = "increase max hp" + str(GameManager.max_hp_cost)
	else:
		print("insufficient funds :(")

extends Button

@export var coin_label: Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	text = "increase damage. cost:" + str(GameManager.damage_cost)
	if GameManager.damage_button_disabled == true:
		disabled = true
	else:
		disabled = false
	SignalManager.increase_max_health_permanent.connect(enable)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func enable():
	GameManager.damage_button_disabled = false
	disabled = false


func _on_pressed() -> void:
	if GameManager.coins_from_run >= GameManager.damage_cost:
		GameManager.coins_from_run -= GameManager.damage_cost
		coin_label.update_coins()
		SignalManager.increase_damage_permanent.emit()
		SignalManager.update_total_coins.emit()
		text = "increase damage. cost:" + str(GameManager.damage_cost)
	else:
		print("insufficient funds :(")

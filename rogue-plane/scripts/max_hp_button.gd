extends Button

@export var coin_label: Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_pressed() -> void:
	if GameManager.total_coins >= GameManager.max_hp_cost:
		GameManager.total_coins -= GameManager.max_hp_cost
		coin_label.update_coins()
		SignalManager.update_max_hp_cost.emit()
		SignalManager.update_total_coins.emit()
	else:
		print("insufficient funds :(")

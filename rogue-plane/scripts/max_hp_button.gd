extends Button

@export var player: PackedScene
@export var coin_label: Label

var cost: int = 1
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	cost == GameManager.max_hp_cost


func _on_pressed() -> void:
	if coin_label.coins >= cost:
		coin_label.coins -= cost
		coin_label.update_coins()
		cost *= 2
		print(cost)
		SignalManager.update_max_hp_cost.emit()
		
	else:
		print("insufficient funds :(")

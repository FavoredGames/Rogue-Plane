extends Button

@export var coin_label: Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_cost()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_pressed() -> void:
	if GameManager.coins_from_run >= GameManager.max_hp_cost:
		GameManager.coins_from_run -= GameManager.max_hp_cost
		coin_label.update_coins()
		SignalManager.increase_max_health_permanent.emit()
		SignalManager.update_total_coins.emit()
		update_cost()
	else:
		print("insufficient funds :(")


func _on_increase_damage_pressed() -> void:
	pass # Replace with function body.


func update_cost():
	text = "+3 MAX HP
	COST:" + str(GameManager.max_hp_cost)

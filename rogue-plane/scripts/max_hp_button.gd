extends Button

@export var coin_label: Label

var cost: int = 5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_pressed() -> void:
	if coin_label.coins >= cost:
		coin_label.coins -= cost
		coin_label.update_coins()
	else:
		print("insufficient funds :(")

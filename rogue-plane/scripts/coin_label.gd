extends Label

var coin = 0


# Siganl used to increase coins for label when player collects a coin.
func _ready() -> void:
	SignalManager.coin_collected.connect(_increase_coin_amount)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


# Increases coins when coin is collected and displays new value.
func _increase_coin_amount():
	coin += 1
	text = str('%03d' % coin)
	

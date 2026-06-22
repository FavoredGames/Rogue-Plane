extends Label

var coin = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalManager.coin_collected.connect(increase_coin_amount)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func increase_coin_amount():
	coin += 1
	text = str('%03d' % coin)
	

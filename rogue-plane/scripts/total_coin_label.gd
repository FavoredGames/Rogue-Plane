extends Label


var coins: int = 0 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	coins += GameManager.coins_from_run
	print(coins)
	text = str('%03d' % coins)
	

func update_coins():
	text = str('%03d' % coins)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

extends Label



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.total_coins
	print(GameManager.total_coins)
	update_coins()
	

func update_coins():
	text = str('%03d' % GameManager.total_coins)
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

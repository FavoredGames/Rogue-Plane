extends Label



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_coins()
	

func update_coins():
	text = str('%03d' % GameManager.coins_from_run)
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

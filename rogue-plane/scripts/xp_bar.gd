extends ProgressBar

@export var player: CharacterBody2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalManager.update_xp.connect(update_xp)
	SignalManager.reset_xp.connect(reset_xp)
	update_xp()


func reset_xp():
	player.xp = 0
	update_xp()


func update_xp():
	value = player.xp * 100 / player.max_xp
	#if player.xp == player.max_xp:
		#player.xp = 0



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

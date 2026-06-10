extends ProgressBar

@export var player: CharacterBody2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalManager.increase_xp.connect(increase_xp)
	increase_xp()

func increase_xp():
	value = player.xp * 100 / player.max_xp
	#if player.xp == player.max_xp:
		#player.xp = 0



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

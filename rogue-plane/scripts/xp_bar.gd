extends ProgressBar

@export var player: CharacterBody2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalManager.update_xp.connect(_update_xp)
	SignalManager.reset_xp.connect(_reset_xp)
	_update_xp()


# Sets the xp value to zero for when the player levels up.
# Then updates the xp bar to display this new value.
func _reset_xp():
	player.xp = 0
	_update_xp()


# Calculates xp value as a percentage of max xp and displays it on xp bar.
func _update_xp():
	value = player.xp * 100 / player.max_xp
	#if player.xp == player.max_xp:
		#player.xp = 0

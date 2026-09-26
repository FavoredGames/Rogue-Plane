extends ProgressBar

@export var player: CharacterBody2D


func _ready() -> void:
	# Tells xp bar when to update for when changes are made to xp value.
	SignalManager.update_xp.connect(_update_xp)
	# Tells xp bar when to reset for when player has levelled up.
	SignalManager.reset_xp.connect(_reset_xp)
	# Makes xp up to date immediately.
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

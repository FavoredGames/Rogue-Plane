extends Sprite2D


# Displays upgrade notifiction sprite if player has enough coins for an upgrade.
func _process(delta: float) -> void:
	if (GameManager.coins_from_run >= GameManager.damage_cost
	or GameManager.coins_from_run >= GameManager.max_hp_cost
	or GameManager.coins_from_run >= GameManager.extra_coin_upgrade_cost):
		show()

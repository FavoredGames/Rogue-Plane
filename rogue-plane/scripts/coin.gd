extends Sprite2D


@export var speed: float = 300.0

# Moves coin down the screen.
func _process(delta: float) -> void:
	move_local_y(speed * delta)


# Deletes coin when in contact with player.
func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("player_hitbox"):
		SignalManager.coin_collected.emit()
		queue_free()


# For when coin is off screen the coin will be deleted.
func _on_timer_timeout() -> void:
	queue_free()

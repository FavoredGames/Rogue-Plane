extends Area2D

var speed: float = 800.0


# Moves bullet up the screen. 
func _process(delta: float) -> void:
	move_local_y(-speed * delta)


# Deletes bullet if it's in the game for to long 
# beacuse if it's in game this long it's off screen
# and needs to be deleted so it doesn't lag the game
func _on_timer_timeout() -> void:
	queue_free()


# Delets bullet when it hits an enemy plane.
func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemy_plane"):
		queue_free()

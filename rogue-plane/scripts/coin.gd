extends Sprite2D


@export var speed: float = 300.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	move_local_y(speed * delta)




func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("player_hitbox"):
		SignalManager.coin_collected.emit()
		queue_free()
		


func _on_timer_timeout() -> void:
	queue_free()

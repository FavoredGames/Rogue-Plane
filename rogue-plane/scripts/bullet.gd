extends Area2D

var speed: float = 800.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	move_local_y(-speed * delta)



func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		pass
	else:
		queue_free()

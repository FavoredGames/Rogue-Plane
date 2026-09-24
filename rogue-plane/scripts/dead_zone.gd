extends CharacterBody2D

var mouse_position = null
var player_position = get_global_position
var direction: Vector2 = Vector2(0.0, 0.0)
var speed: int = 1000


# Moves dead zone to mouse position.
func _process(delta: float) -> void:
	velocity = Vector2(0, 0,)
	mouse_position = get_global_mouse_position()
	var direction = (mouse_position - position)
	velocity =  speed * direction.normalized()
	move_and_slide()


# Used to disable plane movement when on mouse to avoid jittering through emiting signal.
func _on_dead_zone_entered(area: Area2D) -> void:
	if area.is_in_group("player_dead_zone"):
		SignalManager.dead_zone_entered.emit()


# Used to enable plane movement when  noton mouse through emiting signal.
func _on_dead_zone_exited(area: Area2D) -> void:
	if area.is_in_group("player_dead_zone"):
		SignalManager.dead_zone_exited.emit()

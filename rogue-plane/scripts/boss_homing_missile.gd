extends CharacterBody2D

var player: CharacterBody2D
var speed: float = 400.0
var missile_health: int = 100


# Gets the player node so it can get player position.
func _ready() -> void:
	SignalManager.player_died.connect(_delete_self)
	for node in get_tree().get_nodes_in_group("player"):
		player = node


# Used to delete homing missiles when player dies because the scene will change.
func _delete_self():
	queue_free()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# If player is in the scene the missile moves toward the player.
	if not player == null:
		look_at(player.global_position)
		velocity = Vector2(1,0).rotated(rotation) * speed
		move_and_slide()
	if missile_health <= 0:
		queue_free()


func _on_area_2d_area_entered(area: Area2D) -> void:
	# If missile hits player's plane it deletes the missile.
	if area.is_in_group("player_hitbox"):
		queue_free()
	# Missile takes damage when hits player bullet.
	if area.is_in_group("enemy_damagers"):
		missile_health =- 1
		print(missile_health)


# Deletes boss missile if they're in the game for to long 
# beacuse if they're in game this long somethings gone wrong
# and they'll just be causing lag
func _on_timer_timeout() -> void:
	queue_free()

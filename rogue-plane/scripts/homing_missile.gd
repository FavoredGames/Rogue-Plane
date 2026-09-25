extends CharacterBody2D

var player: CharacterBody2D
const SPEED: float = 300.0
var missile_health: int = 2


# Gets player node so player position can be used to move the missile.
func _ready() -> void:
	for node in get_tree().get_nodes_in_group("player"):
		player = node


# Makes missile face player and move toward it.
func _process(delta: float) -> void:
	if not player == null:
		look_at(player.global_position)
		velocity = Vector2(1,0).rotated(rotation) * SPEED
		move_and_slide()
	# Deletes missile if its health is 0.
	if missile_health <= 0:
		queue_free()


func _on_area_2d_area_entered(area: Area2D) -> void:
	# Deletes missile when it collides with player plane.
	if area.is_in_group("player_hitbox"):
		queue_free()
	# Reduces missile health when collided with player bullets.
	if area.is_in_group("enemy_damagers"):
		missile_health =- 1

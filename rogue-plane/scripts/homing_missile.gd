extends CharacterBody2D

var player: CharacterBody2D
var speed: float = 300.0
var missile_health: int = 2

func _ready() -> void:
	for node in get_tree().get_nodes_in_group("player"):
		player = node

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not player == null:
		look_at(player.global_position)
		velocity = Vector2(1,0).rotated(rotation) * speed
		move_and_slide()
	if missile_health <= 0:
		queue_free()


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("player_hitbox"):
		queue_free()
	if area.is_in_group("enemy_damagers"):
		missile_health =- 1
		print(missile_health)


func _on_timer_timeout() -> void:
	queue_free()

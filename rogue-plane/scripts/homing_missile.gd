extends CharacterBody2D

var player: CharacterBody2D
<<<<<<< Updated upstream
var speed: float = 250.0
=======
var speed: float = 300.0
var missile_health: int = 2
>>>>>>> Stashed changes

func _ready() -> void:
	for node in get_tree().get_nodes_in_group("player"):
		player = node

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not player == null:
		look_at(player.global_position)
		velocity = Vector2(1,0).rotated(rotation) * speed
		move_and_slide()


func _on_area_2d_area_entered(area: Area2D) -> void:
	queue_free()

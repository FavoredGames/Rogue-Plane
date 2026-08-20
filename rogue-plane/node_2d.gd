extends Node2D


@export var player: CharacterBody2D
@export var bullet_spawn: Marker2D
@export var bullet_scene: PackedScene

var speed: float = 300.0
var missile_health: int = 2

func _ready() -> void:
	for node in get_tree().get_nodes_in_group("player"):
		player = node


func _physics_process(delta: float) -> void:
	look_at(player.global_position)
# Creates an instance of the bullet at the shooting point
func shoot():
	var bullet = bullet_scene.instantiate()
	bullet.global_position = bullet_spawn.global_position
	add_sibling(bullet)
	#can_shoot = false
	#bullet_timer.start()
# Called when the node enters the scene tree for the first time.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# Fires bullet every time timer finishes
func _on_timer_timeout() -> void:
	shoot()

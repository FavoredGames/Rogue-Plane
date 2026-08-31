extends Area2D

@export var bullet_spawn: Marker2D
var player: CharacterBody2D


func _physics_process(delta: float) -> void:
	pass
# Creates an instance of the ballut at the shooting point
func shoot():
	const BULLET = preload("res://scenes/boss_bullet.tscn")
	var new_bullet = BULLET.instantiate()
	new_bullet.global_position = bullet_spawn.global_position
	new_bullet.global_rotation = bullet_spawn.global_rotation
	bullet_spawn.add_child(new_bullet)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for node in get_tree().get_nodes_in_group("player"):
		player = node


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	look_at(player.global_position)

# Fires bullet every time timer finishes
func _on_timer_timeout() -> void:
	shoot()
	

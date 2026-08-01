extends Node2D

@export var spawn_point: PathFollow2D
@export var basic_enemy_scene: PackedScene
@export var spawn_timer: Timer
@export var advanced_spawn_point: PathFollow2D
@export var advanced_enemy_scene: PackedScene
@export var advanced_enemy_spawn_timer: Timer




func _spawn_basic_enemy() -> void:
	spawn_point.progress_ratio = randf_range(0.0, 1.0)
	var enemy = basic_enemy_scene.instantiate()
	enemy.global_position = spawn_point.global_position
	add_child(enemy)


func _on_spawn_timer_timeout() -> void:
	_spawn_basic_enemy()


func _spawn_advanced_enemy() -> void:
	advanced_spawn_point.progress_ratio = randf_range(0.0, 1.0)
	var advanced_enemy = advanced_enemy_scene.instantiate()
	advanced_enemy.global_position = advanced_spawn_point.global_position
	add_child(advanced_enemy)


func _on_advanced_emeny_spawn_timer_timeout() -> void:
	_spawn_advanced_enemy()
	

extends Node2D

@export var spawn_point: PathFollow2D
@export var basic_enemy_scene: PackedScene
@export var spawn_timer: Timer
@export var advanced_spawn_point: PathFollow2D
@export var advanced_enemy_scene: PackedScene
@export var advanced_enemy_spawn_timer: Timer
@export var boss: PackedScene
@export var boss_health_bar: PackedScene
@export var boss_spawn_point: Marker2D
@export var player: CharacterBody2D
var enemy_can_spawn: bool = true


func _ready() -> void:
	get_tree().paused = true
	await get_tree().create_timer(0.75).timeout
	get_tree().paused = false
	SignalManager.player_died.connect(player_died)

func player_died():
	pass

func _spawn_basic_enemy() -> void:
	if enemy_can_spawn == true:
		spawn_point.progress_ratio = randf_range(0.0, 1.0)
		var enemy = basic_enemy_scene.instantiate()
		enemy.global_position = spawn_point.global_position
		add_child(enemy)


func _on_spawn_timer_timeout() -> void:
	_spawn_basic_enemy()


func _spawn_advanced_enemy() -> void:
	if enemy_can_spawn == true:
		advanced_spawn_point.progress_ratio = randf_range(0.0, 1.0)
		var advanced_enemy = advanced_enemy_scene.instantiate()
		advanced_enemy.global_position = advanced_spawn_point.global_position
		add_child(advanced_enemy)


func _on_advanced_emeny_spawn_timer_timeout() -> void:
	_spawn_advanced_enemy()
	


func _on_boss_timer_timeout() -> void:
	var boss = boss.instantiate()
	boss.global_position = boss_spawn_point.global_position
	add_sibling(boss)
	var boss_health_bar = boss_health_bar.instantiate()
	boss_health_bar.global_position = boss_spawn_point.global_position
	add_sibling(boss_health_bar)
	enemy_can_spawn = false

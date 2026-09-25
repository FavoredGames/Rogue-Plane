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
@export var boss_health_bar_spawn_point: Marker2D
@export var player: CharacterBody2D
@export var blindness: AnimatedSprite2D
@export var phase_2_card: Sprite2D
@export var phase_3_card: Sprite2D
var enemy_can_spawn: bool = true

# Adds slight pause so the player can react to the game starting.
func _ready() -> void:
	get_tree().paused = true
	await get_tree().create_timer(0.75).timeout
	get_tree().paused = false
	SignalManager.start_phase_2.connect(_show_phase_2_card)
	SignalManager.start_phase_3.connect(_show_phase_3)


# When recieved the siganl to do so from the boss diplays the phase 2 card.
func _show_phase_2_card():
	phase_2_card.show()
	await get_tree().create_timer(1.0).timeout
	phase_2_card.hide()


# When recieved the siganl to do so from the boss diplays the phase 3 card.
# Then displays the blindness card.
func _show_phase_3():
	phase_3_card.show()
	await get_tree().create_timer(1.0).timeout
	phase_3_card.hide()
	blindness.show()
	blindness.play()


# Spawns basic enemy on random point of the line above the screen.
func _spawn_basic_enemy() -> void:
	if enemy_can_spawn:
		spawn_point.progress_ratio = randf()
		var enemy = basic_enemy_scene.instantiate()
		enemy.global_position = spawn_point.global_position
		add_child(enemy)


# Spawns enemy after the timer has finished.
func _on_spawn_timer_timeout() -> void:
	_spawn_basic_enemy()


# Spawns homing missile enemy on random point of the line above the screen.
func _spawn_advanced_enemy() -> void:
	if enemy_can_spawn:
		advanced_spawn_point.progress_ratio = randf()
		var advanced_enemy = advanced_enemy_scene.instantiate()
		advanced_enemy.global_position = advanced_spawn_point.global_position
		add_child(advanced_enemy)


# Spawns advanced enemy after the timer has finished.
func _on_advanced_emeny_spawn_timer_timeout() -> void:
	_spawn_advanced_enemy()


# Spawns boss and its health bar and disables other enemy spawning.
func _on_boss_timer_timeout() -> void:
	var boss = boss.instantiate()
	boss.global_position = boss_spawn_point.global_position
	add_sibling(boss)
	var boss_health_bar = boss_health_bar.instantiate()
	boss_health_bar.global_position = boss_health_bar_spawn_point.global_position
	add_sibling(boss_health_bar)
	enemy_can_spawn = false

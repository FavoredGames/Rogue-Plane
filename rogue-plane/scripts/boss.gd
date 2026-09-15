extends CharacterBody2D

var speed = 0
var health: int = 300
var max_health: int = 300
var take_damage: int = 0
@export var bullet_scene: PackedScene
@export var bullet_scene_2: PackedScene
@export var bullet_spawn: Marker2D
@export var bullet_spawn_2: Marker2D
@export var homing_missile_spawn_2: Marker2D
@export var homing_missile_spawn_1: Marker2D
@export var homing_missile_1: PackedScene
@export var homing_missile_2: PackedScene
@export var bullet_timer: Timer
@export var homing_missile_timer: Timer
@export var between_pahse_timer: Timer
@export var enemy_sprite: AnimatedSprite2D
@export var rotation_animation: AnimationPlayer
var can_take_damage: bool = true
var can_shoot: bool = true
var can_fire_missile: bool = true
var between_phase: bool = false
var phase_2_code_has_run: bool = false



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if health <= 0:
		queue_free()
	if health <= (max_health * 0.75):
		rotation_animation.play("boss_rotation")
		if phase_2_code_has_run == false:
			print("phase 2")
			bullet_timer.wait_time = (bullet_timer.wait_time * 0.1)
			between_phase = true
			between_pahse_timer.start()
			phase_2_code_has_run = true
	elif health <= (max_health * 0.25):
		print("phase 3")
	else:
		pass


# Spawns bullet and 
func _shoot() -> void:
	var bullet = bullet_scene.instantiate()
	bullet.rotation = bullet_spawn.rotation
	bullet.global_position = bullet_spawn.global_position
	add_sibling(bullet)
	bullet_timer.start()

func _shoot_2() -> void:
	var bullet_2 = bullet_scene_2.instantiate()
	bullet_2.rotation = bullet_spawn_2.rotation
	bullet_2.global_position = bullet_spawn_2.global_position
	add_sibling(bullet_2)
	bullet_timer.start()

func shoot_homing_missile_1():
	var missile = homing_missile_1.instantiate()
	missile.global_position = homing_missile_spawn_1.global_position
	add_sibling(missile)
	homing_missile_timer.start()


func shoot_homing_missile_2():
	var missile = homing_missile_1.instantiate()
	missile.global_position = homing_missile_spawn_2.global_position
	add_sibling(missile)
	homing_missile_timer.start()


func _on_timer_timeout() -> void:
	if between_phase == false:
		if can_shoot == true:
			_shoot()
			_shoot_2()


func _on_area_2d_area_entered(area: Area2D) -> void:
	if between_phase == false:
		if area.is_in_group("enemy_damagers"):
			if can_take_damage == true:
				health -= GameManager.enemy_damage_take
				enemy_sprite.modulate = Color.RED
				await get_tree().create_timer(0.05).timeout
				enemy_sprite.modulate = Color.WHITE
				SignalManager.boss_take_damage.emit()
			
		


func _on_homing_missile_timeout() -> void:
	if between_phase == false:
		if can_fire_missile == true:
			shoot_homing_missile_1()
			shoot_homing_missile_2()


func _on_between_phase_timer_timeout() -> void:
	between_phase = false

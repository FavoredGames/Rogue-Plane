extends CharacterBody2D

var speed = 0
var health: int = 2000
var max_health: int = 2000
var take_damage: int = 0
var can_take_damage: bool = true
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
@export var between_phase_timer: Timer
@export var between_phase_timer_2: Timer
@export var enemy_sprite: AnimatedSprite2D
@export var boss_animation: AnimationPlayer
@export var laser_hitbox_1: CollisionShape2D
@export var laser_hitbox_2: CollisionShape2D
@export var laser_1: Sprite2D
@export var laser_2: Sprite2D

var can_shoot: bool = true
var can_fire_missile: bool = true
var between_phase: bool = false
var phase_2_code_has_run: bool = false
var phase_3_code_has_run: bool = false
const PHASE_2_START: int = 0.75
const PHASE_2_FINISH: int = 0.25
const NEW_PERCENTAGE_OF_MISSILE_TIME: int = 0.4
const HALF_BULLET_TIMER_VALUE: int = 0.5
const Y_POSITION_RESET: int = 100


# Disables laser hitboxes so they can be anable in phase 2.
# Player_died siuganl connected so boss can be removed when player dies.
func _ready() -> void:
	laser_hitbox_1.disabled = true
	laser_hitbox_2.disabled = true
	SignalManager.player_died.connect(_remove_boss)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Tell the game that the boss has died when boss has zero health
	# so scene can be switched to win screen.
	if health <= 0:
		SignalManager.boss_died.emit()
	# Delets boss if health is zero.
	if not between_phase:
		if health <= 0:
			queue_free()
		# Starts phase 2 if in the health range for phase 2
		if (health <= (max_health * PHASE_2_START) 
		and health > (max_health * PHASE_2_FINISH)):
			if not phase_2_code_has_run:
				
				SignalManager.start_phase_2.emit()
				homing_missile_timer.wait_time = (
					homing_missile_timer.wait_time * NEW_PERCENTAGE_OF_MISSILE_TIME
				)
				between_phase_timer.start()
				phase_2_code_has_run = true
				between_phase = true
				can_shoot = false
				hide()
				await get_tree().create_timer(1.0).timeout
				show()
		elif health <= (max_health * PHASE_2_FINISH):
			if not phase_3_code_has_run:
				homing_missile_timer.wait_time = (
					homing_missile_timer.wait_time * NEW_PERCENTAGE_OF_MISSILE_TIME
				)
				bullet_timer.wait_time = (
					bullet_timer.wait_time * HALF_BULLET_TIMER_VALUE
				)
				SignalManager.start_phase_3.emit()
				position.y += Y_POSITION_RESET
				print("phase 3")
				between_phase_timer_2.start()
				laser_hitbox_1.disabled = true
				laser_hitbox_2.disabled = true
				laser_1.hide()
				laser_2.hide()
				phase_3_code_has_run = true
				between_phase = true
				boss_animation.play("RESET")
				hide()
		else:
			pass
	else:
		pass


# Spawns bullet used when the shoot timer times out. 
func _shoot() -> void:
	var bullet = bullet_scene.instantiate()
	bullet.rotation = bullet_spawn.rotation
	bullet.global_position = bullet_spawn.global_position
	add_sibling(bullet)
	bullet_timer.start()

# Spawns bullet used when the shoot timer times out. 
func _shoot_2() -> void:
	var bullet_2 = bullet_scene_2.instantiate()
	bullet_2.rotation = bullet_spawn_2.rotation
	bullet_2.global_position = bullet_spawn_2.global_position
	add_sibling(bullet_2)
	bullet_timer.start()

# Spawns missile used when the homing missile timer times out. 
func shoot_homing_missile_1():
	var missile = homing_missile_1.instantiate()
	missile.global_position = homing_missile_spawn_1.global_position
	add_sibling(missile)
	homing_missile_timer.start()

# Spawns missile used when the homing missile timer times out. 
func shoot_homing_missile_2():
	var missile = homing_missile_1.instantiate()
	missile.global_position = homing_missile_spawn_2.global_position
	add_sibling(missile)
	homing_missile_timer.start()


func _on_timer_timeout() -> void:
	if not between_phase:
		if can_shoot:
			_shoot()
			_shoot_2()

# Makes the enemy take damage and checks to make sure it is the player's bullet that are hitting it.
func _on_area_2d_area_entered(area: Area2D) -> void:
	if not between_phase:
		if area.is_in_group("enemy_damagers"):
			if can_take_damage:
				health -= GameManager.enemy_damage_take
				# Makes the enemy flash red when it takes damage.
				enemy_sprite.modulate = Color.RED
				await get_tree().create_timer(0.05).timeout
				enemy_sprite.modulate = Color.WHITE
				SignalManager.boss_take_damage.emit()


# Checks that the boss isn't inbetween phases and if not then runs the functions to spawn missiles.
func _on_homing_missile_timeout() -> void:
	if not between_phase:
		if can_fire_missile:
			shoot_homing_missile_1()
			shoot_homing_missile_2()


# Starts phase 2 with lasers and rotation when no longer inbetween phase 1 and 2.
func _on_between_phase_timer_timeout() -> void:
	between_phase = false
	boss_animation.play("boss_rotation")
	laser_hitbox_1.disabled = false
	laser_hitbox_2.disabled = false
	laser_1.show()
	laser_2.show()
				


# Starts phase 3 with the movement animation playing.
func _on_between_phase_timer_2_timeout() -> void:
	between_phase = false
	boss_animation.play("movement")
	can_shoot = true
	can_fire_missile = true
	await get_tree().create_timer(3.0).timeout
	show()


# Removes boss when player has died as part of the signal it recieves.
func _remove_boss():
	queue_free()

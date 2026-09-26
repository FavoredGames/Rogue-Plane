extends CharacterBody2D

@export var player_sprite: Sprite2D
@export var mini_plane_scene: PackedScene
@export var mini_plane_scene_2: PackedScene
@export var bullet_scene: PackedScene
@export var bullet_scene_2: PackedScene
@export var bullet_scene_3: PackedScene
@export var bullet_scene_4: PackedScene
@export var bullet_scene_5: PackedScene
@export var bullet_scene_6: PackedScene
@export var bullet_spawn: Marker2D
@export var bullet_spawn_2: Marker2D
@export var bullet_spawn_3: Marker2D
@export var bullet_spawn_4: Marker2D
@export var bullet_spawn_5: Marker2D
@export var bullet_spawn_6: Marker2D
@export var bullet_timer: Timer
@export var healing_timer: Timer
@export var health: int = 2
@export var healing: int = 1

const GAME_OVER: PackedScene = preload("res://scenes/game_over_screen.tscn")
const PLAYER_HEALTH_INCREASE_VALUE: int = 2
const SPEED: float = 800
const GUN_LIMIT = 6
const XP_INCREASE_VALUE: int = 20
const SHOOTING_FUNCTIONS: Array = [
	"_shoot",
	"_shoot_2",
	"_shoot_3",
	"_shoot_4",
	"_shoot_5",
	"_shoot_6"
]

var max_xp: int = 100
var xp: int = 0
var can_shoot: bool = false
var mouse_position = null
var player_position = get_global_position
var direction: Vector2 = Vector2(0.0, 0.0)
var player_max_hp: int = 0
var guns: int = 2
var moving: bool = true
var mini_planes: int = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Sets the players health and max health to the everchanging 
	# max hp (due to max hp upgrades) stored in the gamemanager.
	health = GameManager.max_hp
	player_max_hp = GameManager.max_hp
	# Tells player when enemy has died, to add xp.
	SignalManager.enemy_plane_died.connect(_enemy_plane_died)
	# Used for when max hp card upgrade is taken to increase max hp for that run.
	SignalManager.increase_max_health_temporary.connect(_increase_max_health_temporary)
	# Used for when max hp upgrade is bought to increase max hp permanently
	SignalManager.increase_max_health_permanent.connect(_increase_max_health_permanent)
	# For when mini plane upgrade to taken.
	SignalManager.add_mini_plane.connect(_add_mini_plane)
		# For when gun upgrade to taken.
	SignalManager.add_gun.connect(_add_gun)
	# Used to stop plane movement when player mouse is in deadzone.
	SignalManager.dead_zone_entered.connect(_dead_zone_entered)
	SignalManager.dead_zone_exited.connect(_dead_zone_exited)


# Increases gun value.
func _add_gun():
	if not guns == GUN_LIMIT:
		guns += 1
	else: 
		pass



func _add_mini_plane():
	# Adds the first mini plane.
	if mini_planes == 0:
		var mini_plane = mini_plane_scene.instantiate()
		mini_plane.global_position = bullet_spawn.global_position
		add_sibling(mini_plane)
		mini_planes += 1
	# Adds the second mini plane.
	else:
		var mini_plane_2 = mini_plane_scene_2.instantiate()
		mini_plane_2.global_position = bullet_spawn.global_position
		add_sibling(mini_plane_2)


# Increases players permenent max health.
func _increase_max_health_permanent():
	GameManager.max_hp += PLAYER_HEALTH_INCREASE_VALUE


# Increases players temporary max health for that run only.
func _increase_max_health_temporary():
	player_max_hp += PLAYER_HEALTH_INCREASE_VALUE
	health += PLAYER_HEALTH_INCREASE_VALUE


# Increases player xp amount and then update the xp bar.
func _enemy_plane_died():
	xp += XP_INCREASE_VALUE
	_update_xp()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Moves player toward mouse position.
	velocity = Vector2(0, 0,)
	mouse_position = get_global_mouse_position()
	var direction = (mouse_position - position)
	velocity =  SPEED * direction.normalized()
	if moving:
		move_and_slide()
	# Changes scene to the game over screen when player health reaches 0.
	if health <= 0:
		get_tree().change_scene_to_packed(GAME_OVER)
		SignalManager.player_died.emit()
	# Makes player shoot but only when the timer is done.
	# Shoots more depending on how many guns it has.
	if can_shoot:
		for i in range(guns):
			call(SHOOTING_FUNCTIONS[i])
		#_shoot()
		#_shoot_2()
		#if guns >= 3:
			#_shoot_3()
		#if guns >= 4:
			#_shoot_4()
		#if guns >= 5:
			#_shoot_5()
		#if guns >= GUN_LIMIT:
			#_shoot_6()
	if xp >= max_xp:
		level_up()


# Increases the max xp needed for the next level up after level up.
func level_up():
	max_xp += XP_INCREASE_VALUE
	SignalManager.card_upgrades.emit()


# Spawns bullet.
func _shoot() -> void:
	var bullet = bullet_scene.instantiate()
	bullet.global_position = bullet_spawn.global_position
	add_sibling(bullet)
	can_shoot = false
	bullet_timer.start()


# Spawns bullet.
func _shoot_2() -> void:
	var bullet_2 = bullet_scene_2.instantiate()
	bullet_2.global_position = bullet_spawn_2.global_position
	add_sibling(bullet_2)
	can_shoot = false
	bullet_timer.start()


# Spawns bullet.
func _shoot_3() -> void:
	var bullet_3 = bullet_scene_3.instantiate()
	bullet_3.global_position = bullet_spawn_3.global_position
	add_sibling(bullet_3)
	can_shoot = false
	bullet_timer.start()


# Spawns bullet.
func _shoot_4() -> void:
	var bullet_4 = bullet_scene_4.instantiate()
	bullet_4.global_position = bullet_spawn_4.global_position
	add_sibling(bullet_4)
	can_shoot = false
	bullet_timer.start()


# Spawns bullet.
func _shoot_5() -> void:
	var bullet_5 = bullet_scene_5.instantiate()
	bullet_5.global_position = bullet_spawn_5.global_position
	add_sibling(bullet_5)
	can_shoot = false
	bullet_timer.start()


# Spawns bullet.
func _shoot_6() -> void:
	var bullet_6 = bullet_scene_6.instantiate()
	bullet_6.global_position = bullet_spawn_6.global_position
	add_sibling(bullet_6)
	can_shoot = false
	bullet_timer.start()


func _on_bullet_timer_timeout() -> void:
	can_shoot = true


func _on_area_2d_area_entered(area: Area2D) -> void:
	# Makes the player take damage and checks to make sure it is the 
	# enemy or enemies bullet that are hitting it.
	if area.is_in_group("damager"):
		const NEW_TIMER_TIME: int = 0.05
		health -= 1
		# Makes the player flash red when it takes damage.
		player_sprite.modulate = Color.RED
		await get_tree().create_timer(NEW_TIMER_TIME).timeout
		player_sprite.modulate = Color.WHITE
		_take_damage()


func _update_xp():
	SignalManager.update_xp.emit()


func _take_damage():
	SignalManager.take_damage.emit()
	

func _dead_zone_entered():
	moving = false


func _dead_zone_exited():
	moving = true

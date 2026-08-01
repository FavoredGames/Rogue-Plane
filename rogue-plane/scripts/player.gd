extends CharacterBody2D

@export var mini_plane_scene: PackedScene
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

var xp_increase_value: int = 100
var max_xp: int = 100
var xp: int = 0
var speed: float = 600
var can_shoot: bool = false
var mouse_position = null
var player_position = get_global_position
var direction: Vector2 = Vector2(0.0, 0.0)
var player_max_hp: int = 0 
var guns: int = 2


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	health = GameManager.max_hp
	SignalManager.enemy_plane_died.connect(enemy_plane_died)
	SignalManager.increase_max_health_temporary.connect(increase_max_health_temporary)
	player_max_hp = GameManager.max_hp
	SignalManager.increase_max_health_permanent.connect(increase_max_health_permanent)
	print(health)
	print("max hp", player_max_hp)
	SignalManager.add_mini_plane.connect(add_mini_plane)
	SignalManager.add_gun.connect(add_gun)
	

func add_gun():
	guns += 1

func add_mini_plane():
	var mini_plane = mini_plane_scene.instantiate()
	mini_plane.global_position = bullet_spawn.global_position
	add_sibling(mini_plane)


func increase_max_health_permanent():
	GameManager.max_hp += 2
	


func increase_max_health_temporary():
	player_max_hp += 2
	health += 2
	print(health)
	print(player_max_hp)


func enemy_plane_died():
	xp += xp_increase_value
	update_xp()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	velocity = Vector2(0, 0,)
	mouse_position = get_global_mouse_position()
	var direction = (mouse_position - position)
	velocity =  speed * direction.normalized()
	move_and_slide()
	if health <= 0:
		get_tree().change_scene_to_packed(GAME_OVER)
	# Makes player shoot but only when the timer is done
	if can_shoot:
		_shoot()
		_shoot_2()
		if guns >= 3:
			_shoot_3()
		if guns >= 4:
			_shoot_4()
		if guns >= 5:
			_shoot_5()
		if guns >= 6:
			_shoot_6()
	if xp == max_xp:
		level_up()

func level_up():
	SignalManager.card_upgrades.emit()

# Spawns bullet and 
func _shoot() -> void:
	var bullet = bullet_scene.instantiate()
	bullet.global_position = bullet_spawn.global_position
	add_sibling(bullet)
	can_shoot = false
	bullet_timer.start()

func _shoot_2() -> void:
	var bullet_2 = bullet_scene_2.instantiate()
	bullet_2.global_position = bullet_spawn_2.global_position
	add_sibling(bullet_2)
	can_shoot = false
	bullet_timer.start()


func _shoot_3() -> void:
	var bullet_3 = bullet_scene_3.instantiate()
	bullet_3.global_position = bullet_spawn_3.global_position
	add_sibling(bullet_3)
	can_shoot = false
	bullet_timer.start()


func _shoot_4() -> void:
	var bullet_4 = bullet_scene_4.instantiate()
	bullet_4.global_position = bullet_spawn_4.global_position
	add_sibling(bullet_4)
	can_shoot = false
	bullet_timer.start()


func _shoot_5() -> void:
	var bullet_5 = bullet_scene_5.instantiate()
	bullet_5.global_position = bullet_spawn_5.global_position
	add_sibling(bullet_5)
	can_shoot = false
	bullet_timer.start()


func _shoot_6() -> void:
	var bullet_6 = bullet_scene_6.instantiate()
	bullet_6.global_position = bullet_spawn_6.global_position
	add_sibling(bullet_6)
	can_shoot = false
	bullet_timer.start()


func _on_bullet_timer_timeout() -> void:
	can_shoot = true


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("damager"):
		health -= 1
		take_damage()
		




func update_xp():
	SignalManager.update_xp.emit()


func take_damage():
	SignalManager.take_damage.emit()


#func _on_healing_timer_timeout() -> void:
	#if health < GameManager.max_hp:
		#health += healing
		#healing_timer.start()

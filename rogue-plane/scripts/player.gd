extends CharacterBody2D


@export var bullet_scene: PackedScene
@export var bullet_scene_2: PackedScene
@export var bullet_spawn: Marker2D
@export var bullet_spawn_2: Marker2D
@export var bullet_timer: Timer
@export var healing_timer: Timer
const GAME_OVER: PackedScene = preload("res://scenes/game_over_screen.tscn")
var xp_increase_value: int = 25
var max_xp: int = 100
var xp: int = 0
var speed: float = 600
var max_health: int = 2
@export var health: int = 2
@export var healing: int = 1
var can_shoot: bool = false
var mouse_position = null
var player_position = get_global_position
var direction: Vector2 = Vector2(0.0, 0.0)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalManager.enemy_plane_died.connect(enemy_plane_died)
	SignalManager.increase_max_health.connect(increase_max_health)
	
	
	



	


func increase_max_health():
	max_health += 2
	


func enemy_plane_died():
	xp += xp_increase_value
	update_xp()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	velocity = Vector2(0, 0)
	mouse_position = get_global_mouse_position()
	var direction = (mouse_position - position)
	velocity = speed * direction.normalized()
	move_and_slide()
	if health <= 0:
		get_tree().change_scene_to_packed(GAME_OVER)
	# Makes player shoot but only when the timer is done
	if can_shoot:
		_shoot()
		_shoot_2()
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


func _on_healing_timer_timeout() -> void:
	if health < max_health:
		health += healing
		healing_timer.start()

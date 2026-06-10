extends CharacterBody2D


@export var bullet_scene: PackedScene
@export var bullet_scene_2: PackedScene
@export var bullet_spawn: Marker2D
@export var bullet_spawn_2: Marker2D
@export var bullet_timer: Timer
var xp: int = 0
var speed: float = 600
var max_health: int = 10
var health: int = 10
var can_shoot: bool = false
var mouse_position = null
var player_position = get_global_position
var direction: Vector2 = Vector2(0.0, 0.0)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalManager.enemy_plane_died.connect(enemy_plane_died)


func enemy_plane_died():
	xp += 1
	print(xp)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	velocity = Vector2(0, 0)
	mouse_position = get_global_mouse_position()
	var direction = (mouse_position - position)
	velocity = speed * direction.normalized()
	move_and_slide()
	if health <= 0:
		get_tree().call_deferred("reload_current_scene")
	# Makes player shoot but only when the timer is done
	if can_shoot:
		_shoot()
		_shoot_2()
	if xp == 1:
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
		#print(health)


func take_damage():
	SignalManager.take_damage.emit()

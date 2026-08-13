extends CharacterBody2D

var speed = 100
var horinzontal_speed: int = 50
var health: int = 10
var take_damage: int = 0
@export var bullet_scene: PackedScene
@export var bullet_spawn: Marker2D
@export var bullet_timer: Timer
@export var coin_scene: PackedScene
@export var coin_spawn: Marker2D
@export var coin_spawn_2: Marker2D
var pecentage = randf()
var can_shoot: bool = false
var zigzag_num: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalManager.increase_damage.connect(increase_damage)


func increase_damage():
	take_damage += 1
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Makes player shoot but only when the timer is done
	if can_shoot:
		_shoot()
	move_local_y(speed * delta)
	if zigzag_num % 2 == 0:
		move_local_x(horinzontal_speed * delta)
	else:
		move_local_x(-horinzontal_speed * delta)
	if health <= 0:
		SignalManager.enemy_plane_died.emit()
		spawn_coin()
		if pecentage <= GameManager.second_coin_chance:
			spawn_coin_2()
		queue_free()

func spawn_coin() -> void:
	var coin = coin_scene.instantiate()
	coin.global_position = coin_spawn.global_position
	add_sibling(coin)
	


func spawn_coin_2() -> void:
	var coin = coin_scene.instantiate()
	coin.global_position = coin_spawn_2.global_position
	add_sibling(coin)


# Spawns bullet and 
func _shoot() -> void:
	var bullet = bullet_scene.instantiate()
	bullet.global_position = bullet_spawn.global_position
	add_sibling(bullet)
	can_shoot = false
	bullet_timer.start()


func _on_timer_timeout() -> void:
	can_shoot = true


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemy_damagers"):
		var total_damage_take = take_damage + GameManager.enemy_damage_take
		health -= total_damage_take
		print(health)
		


func _on_zigzag_timer_timeout() -> void:
	zigzag_num += 1


func _on_timer_2_timeout() -> void:
	queue_free()
	print("Advanced enemy gone")

extends CharacterBody2D

var speed = 100
var horinzontal_speed: int = 50
var health: int = 20
var take_damage: int = 0
@export var bullet_scene: PackedScene
@export var bullet_spawn: Marker2D
@export var bullet_timer: Timer
@export var coin_scene: PackedScene
@export var coin_spawn: Marker2D
@export var coin_spawn_2: Marker2D
@export var advanced_enemy_sprite: Sprite2D
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
	# Makes plane shoot but only when the shoot timer is done.
	if can_shoot:
		_shoot()
		# Makes the enemy move downwards.
	move_local_y(speed * delta)
	# Makes enemy zigzag left and right when the zigzag timer times out it changes direction.
	if zigzag_num % 2 == 0:
		move_local_x(horinzontal_speed * delta)
	else:
		move_local_x(-horinzontal_speed * delta)
	# Deletes the enemy when it reaches 0 health and spawns 1 or 2 coins.
	if health <= 0:
		SignalManager.enemy_plane_died.emit()
		spawn_coin()
		if pecentage <= GameManager.second_coin_chance:
			spawn_coin_2()
		queue_free()


# Spawns coin used when enemy dies.
func spawn_coin() -> void:
	var coin = coin_scene.instantiate()
	coin.global_position = coin_spawn.global_position
	add_sibling(coin)
	


# Spawns coin used when enemy dies.
func spawn_coin_2() -> void:
	var coin = coin_scene.instantiate()
	coin.global_position = coin_spawn_2.global_position
	add_sibling(coin)


# Spawns missile used when the shoot timer times out. 
func _shoot() -> void:
	var bullet = bullet_scene.instantiate()
	bullet.global_position = bullet_spawn.global_position
	add_sibling(bullet)
	can_shoot = false
	bullet_timer.start()


# Makes the enemy able to shoot when the shoot timer times out.
func _on_timer_timeout() -> void:
	can_shoot = true


# Makes the enemy take damage and checks to make sure it is the player's bullet that are hitting it.
func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemy_damagers"):
		var total_damage_take = take_damage + GameManager.enemy_damage_take
		health -= total_damage_take
		# Makes the enemy flash red when it takes damage.
		advanced_enemy_sprite.modulate = Color.RED
		await get_tree().create_timer(0.05).timeout
		advanced_enemy_sprite.modulate = Color.WHITE
		


# Increases the zigzag number when the zigzag timer is done to control the planes movement left or right
func _on_zigzag_timer_timeout() -> void:
	zigzag_num += 1


# Deletes the enemy if it's been instatiated to long because it'll be off screen by then.
func _on_timer_2_timeout() -> void:
	queue_free()
	print("Advanced enemy gone")

extends CharacterBody2D

var speed = 0
var health: int = 10
var max_health: int = 10
var take_damage: int = 0
@export var bullet_scene: PackedScene
@export var bullet_scene_2: PackedScene
@export var bullet_spawn: Marker2D
@export var bullet_spawn_2: Marker2D
@export var bullet_timer: Timer
@export var enemy_sprite: Sprite2D
var pecentage = randf()
var can_shoot: bool = false
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Makes player shoot but only when the timer is done
	if can_shoot:
		_shoot()
		_shoot_2()
	move_local_y(speed * delta)
	if health <= 0:
		queue_free()


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


func _on_timer_timeout() -> void:
	can_shoot = true


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemy_damagers"):
		var total_damage_take = take_damage + GameManager.enemy_damage_take
		health -= total_damage_take
		enemy_sprite.modulate = Color.RED
		await get_tree().create_timer(0.05).timeout
		enemy_sprite.modulate = Color.WHITE
		SignalManager.boss_take_damage.emit()
		
		

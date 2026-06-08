extends CharacterBody2D

var speed = 100
var health: int = 10
@export var bullet_scene: PackedScene
@export var bullet_scene_2: PackedScene
@export var bullet_spawn: Marker2D
@export var bullet_spawn_2: Marker2D
@export var bullet_timer: Timer
var can_shoot: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Makes player shoot but only when the timer is done
	if can_shoot:
		_shoot()
		_shoot_2()
	move_local_y(speed * delta)
	if health <= 0:
		SignalManager.enemy_plane_died.emit()
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
		health -= 1
		#print(health)

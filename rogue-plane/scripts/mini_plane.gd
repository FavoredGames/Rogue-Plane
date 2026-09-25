extends CharacterBody2D


const SPEED: float = 450
@export var bullet_scene: PackedScene
@export var bullet_scene_2: PackedScene
@export var bullet_spawn: Marker2D
@export var bullet_spawn_2: Marker2D
@export var bullet_timer: Timer
var can_shoot: bool = false
var mouse_position = null
var player_position = get_global_position
var direction: Vector2 = Vector2(0.0, 0.0)
var offset: Vector2 = Vector2(-100.0, -100.0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Moves the plane to mouse postition with an offest to the bottom rignt.
	velocity = Vector2(0, 0)
	mouse_position = get_global_mouse_position()
	var direction = (mouse_position - position - offset)
	velocity = SPEED * direction.normalized()
	move_and_slide()
	# Makes mini plane shoot but only when the timer is done.
	if can_shoot:
		_shoot()
		


# Spawns bullet 
func _shoot() -> void:
	var bullet = bullet_scene.instantiate()
	bullet.global_position = bullet_spawn.global_position
	add_sibling(bullet)
	can_shoot = false
	bullet_timer.start()


# Allows the mini plane to shoot when timer finishes.
func _on_bullet_timer_timeout() -> void:
	can_shoot = true

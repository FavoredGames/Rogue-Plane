extends CharacterBody2D


var speed: float = 450
@export var bullet_scene: PackedScene
@export var bullet_scene_2: PackedScene
@export var bullet_spawn: Marker2D
@export var bullet_spawn_2: Marker2D
@export var bullet_timer: Timer
var can_shoot: bool = false
var mouse_position = null
var player_position = get_global_position
var direction: Vector2 = Vector2(0.0, 0.0)
var offset: Vector2 = Vector2(100.0, -100.0)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	velocity = Vector2(0, 0)
	mouse_position = get_global_mouse_position()
	var direction = (mouse_position - position - offset)
	velocity = speed * direction.normalized()
	move_and_slide()
	# Makes player shoot but only when the timer is done
	if can_shoot:
		_shoot()
		#_shoot_2()



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

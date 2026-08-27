extends CharacterBody2D

var speed = 0
var health: int = 10
var take_damage: int = 0
@export var boss_sprite: Sprite2D
var pecentage = randf()
var can_shoot: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalManager.increase_damage.connect(increase_damage)


func increase_damage():
	take_damage += 1
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Makes player shoot but only when the timer is done
	move_local_y(speed * delta)
	if health <= 0:
		SignalManager.enemy_plane_died.emit()






func _on_timer_timeout() -> void:
	can_shoot = true


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemy_damagers"):
		var total_damage_take = take_damage + GameManager.enemy_damage_take
		health -= total_damage_take
		boss_sprite.modulate = Color.RED
		await get_tree().create_timer(0.05).timeout
		boss_sprite.modulate = Color.WHITE
		
		

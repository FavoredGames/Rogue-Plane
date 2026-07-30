extends Control

@export var card_spawn_1: Marker2D
@export var card_spawn_2: Marker2D
@export var card_spawn_3: Marker2D
@export var health_increase_card: Button
@export var damage_increase_card: Button
@export var attack_speed_increase_card: Button
@export var add_mini_plane_card: Button
@export var add_gun_card: Button
var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalManager.card_upgrades.connect(show_upgrade_cards)
	
	

func show_upgrade_cards():
	visible = true
	var health_increase_num = rng.randf_range(0.0, 100.0)
	print("health increase", health_increase_num)
	var damage_increase_num = rng.randf_range(0.0, 100.0)
	print(damage_increase_num)
	var attack_speed_increase_num = rng.randf_range(0.0, 100.0)
	print(attack_speed_increase_num)
	var add_mini_plane_num = rng.randf_range(0.0, 100.0)
	print(add_mini_plane_num)
	var add_gun_num = rng.randf_range(0.0, 100.0)
	print("gun num", add_gun_num)
	var numbers =[health_increase_num, damage_increase_num, 
	attack_speed_increase_num, add_mini_plane_num, add_gun_num]
	numbers.sort()
	numbers.reverse()
	var top_one = numbers.slice(0,1)
	print(top_one)
	if health_increase_num in top_one:
		print("works")
		health_increase_card.visible = true
		health_increase_card.global_position = card_spawn_1.global_position
	#var top_three = numbers.slice(0,3)
	#print(top_three)
	#if health_increase_num in top_three:
		#print("works")
		#health_increase_card.visible = true
		#health_increase_card.global_position = card_spawn_1.global_position
	#damage_increase_card.visible = true
	#damage_increase_card.global_position = card_spawn_2.global_position
	#attack_speed_increase_card.visible = true
	#attack_speed_increase_card.global_position = card_spawn_3.global_position
	get_tree().paused = true


func _on_health_increase_card_pressed() -> void:
	SignalManager.increase_max_health_temporary.emit()
	unpause()


func _on_damage_increase_card_pressed() -> void:
	SignalManager.increase_damage.emit()
	unpause()


func _on_increase_attack_speed_pressed() -> void:
	SignalManager.increase_attack_speed.emit()
	unpause()


func unpause():
	visible = false
	SignalManager.reset_xp.emit()
	get_tree().paused = false


func _on_add_mini_plane_pressed() -> void:
	SignalManager.add_mini_plane.emit()
	unpause()


func _on_add_gun_pressed() -> void:
	SignalManager.add_gun.emit()
	unpause()


func _on_unpause_button_pressed() -> void:
	unpause()

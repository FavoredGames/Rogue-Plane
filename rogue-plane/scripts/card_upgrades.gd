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
var card_list: Array = [health_increase_card, damage_increase_card, 
attack_speed_increase_card, add_mini_plane_card, add_gun_card]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalManager.card_upgrades.connect(show_upgrade_cards)
	
	


func _process(delta: float) -> void:
	pass


func show_card(id):
	if id == 1:
		health_increase_card.visible = true
	
	if id == 2:
		damage_increase_card.visible = true
		
	if id == 3:
		attack_speed_increase_card.visible = true
		
	if id == 4:
		add_mini_plane_card.visible = true
		
	if id == 5:
		add_gun_card.visible = true
	


func show_upgrade_cards():
	visible = true
	var random_int = randi_range(0,5)
	print("randint", random_int)
		
	if random_int == 1:
		show_card(1)
	elif random_int == 2: 
		show_card(2)
	elif random_int == 3: 
		show_card(3)
	elif random_int == 4: 
		show_card(4)
	else: 
		show_card(5)
	#var first_card = card_list.pick_random()
	#first_card.visible = true
	#first_card.global_position = card_spawn_1.global_position
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
	health_increase_card.visible = false
	unpause()


func _on_damage_increase_card_pressed() -> void:
	SignalManager.increase_damage.emit()
	damage_increase_card.visible = false
	unpause()


func _on_increase_attack_speed_pressed() -> void:
	SignalManager.increase_attack_speed.emit()
	attack_speed_increase_card.visible = false
	unpause()


func unpause():
	visible = false
	SignalManager.reset_xp.emit()
	get_tree().paused = false


func _on_add_mini_plane_pressed() -> void:
	SignalManager.add_mini_plane.emit()
	add_mini_plane_card.visible = false
	unpause()


func _on_add_gun_pressed() -> void:
	SignalManager.add_gun.emit()
	add_gun_card.visible = false
	unpause()


func _on_unpause_button_pressed() -> void:
	unpause()

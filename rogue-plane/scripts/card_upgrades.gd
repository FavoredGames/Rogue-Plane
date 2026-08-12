extends Control

@export var card_spawn_1: Marker2D
@export var card_spawn_2: Marker2D
@export var card_spawn_3: Marker2D
@export var health_increase_card: Button
@export var damage_increase_card: Button
@export var attack_speed_increase_card: Button
@export var add_mini_plane_card: Button
@export var add_gun_card: Button
var first_card: int = 1
var second_card: int = 2
var third_card: int = 3
var card_num: int = 1


#var rng = RandomNumberGenerator.new()
#var card_list: Array = [health_increase_card, damage_increase_card, 
#attack_speed_increase_card, add_mini_plane_card, add_gun_card]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalManager.card_upgrades.connect(show_upgrade_cards)
	
	


func _process(delta: float) -> void:
	pass
	
	
	
func increase_card_num():
	card_num += 1
	


func reset_card_num():
	card_num = 0

func show_card(id):
	print("caard num", card_num)
	if id == 1:
		health_increase_card.visible = true
		print("show health card")
		#if card_num == first_card:
			#health_increase_card.position = card_spawn_1.global_position
			#increase_card_num()
		#elif card_num == second_card:
			#health_increase_card.position = card_spawn_2.global_position
			#increase_card_num()
		#else:
			#health_increase_card.position = card_spawn_3.global_position
			#reset_card_num()

	if id == 2:
		damage_increase_card.visible = true
		print("show damage card")
		#if card_num == first_card:
			#damage_increase_card.position = card_spawn_1.global_position
			#increase_card_num()
		#elif card_num == second_card:
			#damage_increase_card.position = card_spawn_2.global_position
			#increase_card_num()
		#else:
			#damage_increase_card.position = card_spawn_3.global_position
			#reset_card_num()

	if id == 3:
		attack_speed_increase_card.visible = true
		print("show atks card")
		#if card_num == first_card:
			#attack_speed_increase_card.position = card_spawn_1.global_position
			#increase_card_num()
		#elif card_num == second_card:
			#attack_speed_increase_card.position = card_spawn_2.global_position
			#increase_card_num()
		#else:
			#attack_speed_increase_card.position = card_spawn_3.global_position
			#reset_card_num()
			
	if id == 4:
		add_mini_plane_card.visible = true
		print("show mini card")
		#if card_num == first_card:
			#add_mini_plane_card.position = card_spawn_1.global_position
			#increase_card_num()
		#elif card_num == second_card:
			#add_mini_plane_card.position = card_spawn_2.global_position
			#increase_card_num()
		#else:
			#add_mini_plane_card.position = card_spawn_3.global_position
			#reset_card_num()

	if id == 5:
		add_gun_card.visible = true
		print("show gun card")
		#if card_num == first_card:
			#add_gun_card.position = card_spawn_1.global_position
			#increase_card_num()
		#elif card_num == second_card:
			#add_gun_card.position = card_spawn_2.global_position
			#increase_card_num()
		#else:
			#add_gun_card.position = card_spawn_3.global_position
			#reset_card_num()


func show_upgrade_cards():
	visible = true
	print("---=--------------------------")
	var random_int = randi_range(1,5)
	print("randint:", random_int)
		
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
		
	var random_int_2 = randi_range(1,5)
	print("randint2:", random_int_2)
	while random_int_2 == random_int:
		random_int_2 = randi_range(1,5)
		print("randint2:", random_int_2)
		if random_int_2 != random_int:
			break
	
	if random_int_2 == 1:
		show_card(1)
	elif random_int_2 == 2: 
		show_card(2)
	elif random_int_2 == 3: 
		show_card(3)
	elif random_int_2 == 4: 
		show_card(4)
	else: 
		show_card(5)
		
	var random_int_3 = randi_range(1,5)
	print("randint3:", random_int_3)
	while random_int_3 == random_int or random_int_3 == random_int_2:
		random_int_3 = randi_range(1,5)
		print("randint3:", random_int_3)
		print("hmmm")
		if random_int_3 == random_int_2 or random_int_3 == random_int:
			pass
		else:
			print("break")
			break
	if random_int_3 == 1:
		show_card(1)
	elif random_int_3 == 2: 
		show_card(2)
	elif random_int_3 == 3: 
		show_card(3)
	elif random_int_3 == 4: 
		show_card(4)
	else: 
		show_card(5)
	
	get_tree().paused = true


func _on_health_increase_card_pressed() -> void:
	SignalManager.increase_max_health_temporary.emit()
	hide_buttons()
	unpause()


func _on_damage_increase_card_pressed() -> void:
	SignalManager.increase_damage.emit()
	hide_buttons()
	unpause()


func _on_increase_attack_speed_pressed() -> void:
	SignalManager.increase_attack_speed.emit()
	hide_buttons()
	unpause()



func _on_add_mini_plane_pressed() -> void:
	SignalManager.add_mini_plane.emit()
	hide_buttons()
	unpause()


func _on_add_gun_pressed() -> void:
	SignalManager.add_gun.emit()
	hide_buttons()
	unpause()


func unpause():
	visible = false
	SignalManager.reset_xp.emit()
	get_tree().paused = false


func hide_buttons():
	add_gun_card.visible = false
	add_mini_plane_card.visible = false
	attack_speed_increase_card.visible = false
	damage_increase_card.visible = false
	health_increase_card.visible = false



func _on_unpause_button_pressed() -> void:
	unpause()

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
var max_guns: int = 6
var guns: int = 2
var mini_planes: int = 0
var max_mini_planes: int = 2


#var rng = RandomNumberGenerator.new()
#var card_list: Array = [health_increase_card, damage_increase_card, 
#attack_speed_increase_card, add_mini_plane_card, add_gun_card]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalManager.card_upgrades.connect(show_upgrade_cards)


# Disables upgrades if they're already maxed out. 
func _process(delta: float) -> void:
	if guns == max_guns:
		add_gun_card.disabled = true
	else:
		pass
	if mini_planes == max_mini_planes:
		add_mini_plane_card.disabled = true
	else:
		pass



func increase_card_num():
	card_num += 1


func reset_card_num():
	card_num = 0


# Gives an id to each possible upgrade card.
func show_card(id):
	print("caard num", card_num)
	if id == 1:
		health_increase_card.visible = true
		print("show health card")

	if id == 2:
		damage_increase_card.visible = true
		print("show damage card")


	if id == 3:
		attack_speed_increase_card.visible = true
		print("show atks card")
		
			
	if id == 4:
		add_mini_plane_card.visible = true
		print("show mini card")
		

	if id == 5:
		add_gun_card.visible = true
		print("show gun card")


# Picks 1st card to show and diplays it then picks the second and repicks if it is the same as 
# the 1st. thenb p[icks the 3rd making sure it isn't the same as 1st or 2nd
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


# Emits signal for the game manager to connect to
# so player health can be increased in the game manager.
func _on_health_increase_card_pressed() -> void:
	SignalManager.increase_max_health_temporary.emit()
	hide_buttons()
	unpause()

# Emits signal for the player to connect to
# so player damage can be increased in the player script.
func _on_damage_increase_card_pressed() -> void:
	SignalManager.increase_damage.emit()
	hide_buttons()
	unpause()

# Emits signal for the player to connect to
# so player attack speed can be increased in the player script.
func _on_increase_attack_speed_pressed() -> void:
	SignalManager.increase_attack_speed.emit()
	hide_buttons()
	unpause()


# Emits signal for the player to connect to
# so player mini planes can be increased in the player script.
func _on_add_mini_plane_pressed() -> void:
	SignalManager.add_mini_plane.emit()
	hide_buttons()
	mini_planes += 1
	unpause()


# Emits signal for the player to connect to
# so player guns can be increased in the player script.
func _on_add_gun_pressed() -> void:
	SignalManager.add_gun.emit()
	hide_buttons()
	guns += 1
	unpause()


# Unpauses the game for when an upgrade has been picked.
func unpause():
	visible = false
	SignalManager.reset_xp.emit()
	# Creates short delay so the player can react.
	await get_tree().create_timer(0.4).timeout
	get_tree().paused = false


func hide_buttons():
	add_gun_card.visible = false
	add_mini_plane_card.visible = false
	attack_speed_increase_card.visible = false
	damage_increase_card.visible = false
	health_increase_card.visible = false



func _on_unpause_button_pressed() -> void:
	unpause()

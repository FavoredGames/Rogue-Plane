extends Control

@export var card_spawn_1: Marker2D
@export var card_spawn_2: Marker2D
@export var card_spawn_3: Marker2D
@export var health_increase_card: Button
@export var damage_increase_card: Button
@export var attack_speed_increase_card: Button
@export var add_mini_plane_card: Button
@export var add_gun_card: Button
var card_num: int = 1
var guns: int = 2
var mini_planes: int = 0
const MAX_MINI_PLANES: int = 2
const MAX_GUNS: int = 6
const HEALTH_CARD_ID: int = 1
const DAMAGE_CARD_ID: int = 2
const ATTACK_SPEED_CARD_ID: int = 3
const MINI_PLANE_CARD_ID: int = 4
const GUN_CARD_ID: int = 5


#var rng = RandomNumberGenerator.new()
#var card_list: Array = [health_increase_card, damage_increase_card, 
#attack_speed_increase_card, add_mini_plane_card, add_gun_card]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalManager.card_upgrades.connect(_show_upgrade_cards)


# Disables upgrades if they're already maxed out. 
func _process(delta: float) -> void:
	if guns == MAX_GUNS:
		add_gun_card.disabled = true
	else:
		pass
	if mini_planes == MAX_MINI_PLANES:
		add_mini_plane_card.disabled = true
	else:
		pass


#func increase_card_num():
	#card_num += HEALTH_CARD_ID


#func reset_card_num():
	#card_num = 0


# Gives an id to each possible upgrade card.
func _show_card(id):
	if id == HEALTH_CARD_ID:
		health_increase_card.visible = true
	if id == DAMAGE_CARD_ID:
		damage_increase_card.visible = true
	if id == ATTACK_SPEED_CARD_ID:
		attack_speed_increase_card.visible = true
	if id == MINI_PLANE_CARD_ID:
		add_mini_plane_card.visible = true
	if id == GUN_CARD_ID:
		add_gun_card.visible = true


# Picks 1st card to show and diplays it then picks the second and repicks if 
# it is the same as  the 1st. then picks the 3rd making sure it isn't the same 
# as 2st or 2nd.
func _show_upgrade_cards():
	visible = true
	var random_int = randi_range(HEALTH_CARD_ID,GUN_CARD_ID)
	if random_int == HEALTH_CARD_ID:
		_show_card(HEALTH_CARD_ID)
	elif random_int == DAMAGE_CARD_ID: 
		_show_card(DAMAGE_CARD_ID)
	elif random_int == ATTACK_SPEED_CARD_ID: 
		_show_card(ATTACK_SPEED_CARD_ID)
	elif random_int == MINI_PLANE_CARD_ID: 
		_show_card(MINI_PLANE_CARD_ID)
	else: 
		_show_card(GUN_CARD_ID)
	var random_int_DAMAGE_CARD_ID = randi_range(HEALTH_CARD_ID,GUN_CARD_ID)
	while random_int_DAMAGE_CARD_ID == random_int:
		random_int_DAMAGE_CARD_ID = randi_range(HEALTH_CARD_ID,GUN_CARD_ID)
		if random_int_DAMAGE_CARD_ID != random_int:
			break
	if random_int_DAMAGE_CARD_ID == HEALTH_CARD_ID:
		_show_card(HEALTH_CARD_ID)
	elif random_int_DAMAGE_CARD_ID == DAMAGE_CARD_ID: 
		_show_card(DAMAGE_CARD_ID)
	elif random_int_DAMAGE_CARD_ID == ATTACK_SPEED_CARD_ID: 
		_show_card(ATTACK_SPEED_CARD_ID)
	elif random_int_DAMAGE_CARD_ID == MINI_PLANE_CARD_ID: 
		_show_card(MINI_PLANE_CARD_ID)
	else: 
		_show_card(GUN_CARD_ID)
	var random_int_3 = randi_range(HEALTH_CARD_ID,GUN_CARD_ID)
	while random_int_3 == random_int or random_int_3 == random_int_DAMAGE_CARD_ID:
		random_int_3 = randi_range(HEALTH_CARD_ID,GUN_CARD_ID)
		if random_int_3 == random_int_DAMAGE_CARD_ID or random_int_3 == random_int:
			pass
		else:
			break
	if random_int_3 == HEALTH_CARD_ID:
		_show_card(HEALTH_CARD_ID)
	elif random_int_3 == DAMAGE_CARD_ID: 
		_show_card(DAMAGE_CARD_ID)
	elif random_int_3 == ATTACK_SPEED_CARD_ID: 
		_show_card(ATTACK_SPEED_CARD_ID)
	elif random_int_3 == MINI_PLANE_CARD_ID: 
		_show_card(MINI_PLANE_CARD_ID)
	else: 
		_show_card(GUN_CARD_ID)
	get_tree().paused = true


# Emits signal for the game manager to connect to
# so player health can be increased in the game manager.
func _on_health_increase_card_pressed() -> void:
	SignalManager.increase_max_health_temporary.emit()
	_hide_buttons()
	unpause()

# Emits signal for the player to connect to
# so player damage can be increased in the player script.
func _on_damage_increase_card_pressed() -> void:
	SignalManager.increase_damage.emit()
	_hide_buttons()
	unpause()

# Emits signal for the player to connect to
# so player attack speed can be increased in the player script.
func _on_increase_attack_speed_pressed() -> void:
	SignalManager.increase_attack_speed.emit()
	_hide_buttons()
	unpause()


# Emits signal for the player to connect to
# so player mini planes can be increased in the player script.
func _on_add_mini_plane_pressed() -> void:
	SignalManager.add_mini_plane.emit()
	_hide_buttons()
	mini_planes += HEALTH_CARD_ID
	unpause()


# Emits signal for the player to connect to
# so player guns can be increased in the player script.
func _on_add_gun_pressed() -> void:
	SignalManager.add_gun.emit()
	_hide_buttons()
	guns += 1
	unpause()


# Unpauses the game for when an upgrade has been picked.
func unpause():
	visible = false
	SignalManager.reset_xp.emit()
	# Creates short delay so the player can react.
	await get_tree().create_timer(0.4).timeout
	get_tree().paused = false


# Hides all buttons because the card has been picked.
func _hide_buttons():
	add_gun_card.visible = false
	add_mini_plane_card.visible = false
	attack_speed_increase_card.visible = false
	damage_increase_card.visible = false
	health_increase_card.visible = false


# Upauses the game because the card has been picked.
func _on_unpause_button_pressed() -> void:
	unpause()

extends Node


const GAME: PackedScene = preload("res://scenes/main.tscn")
const SKILL_TREE: PackedScene = preload("res://scenes/skill_tree.tscn")
const WIN_SCREEN: PackedScene = preload("res://scenes/win_screen.tscn")
const MAX_HP_INCREASE_VALUE: int = 3
const EXTRA_COIN_CHANCE_INCREASE_VALUE: float = 0.1
const DAMAGE_BASE_COST: int = 10
const MAX_HP_BASE_COST: int = 1
const EXTRA_COIN_BASE_COST: int = 2
const BASE_COST_SCALE: float = 1.5
const MULTIPLICATIVE_COST_SCALING_VALUE: float = 0.75
const EXPONENTIAL_COST_SCALING_VALUE: float = 1.15

var max_hp_cost: int = 1
var max_hp_level: int = 1
var damage_cost: int = 10
var damage_level: int = 1
var total_coins: int = 1
var coins_from_run: int = 0
var max_hp: int = 4
var enemy_damage_take: int = 2
var extra_coin_upgrade_cost: int = 2
var extra_coin_level: int = 1
var second_coin_chance: float = 0.0
var damage_button_disabled: bool = true


func _ready() -> void:
	# Load game is needed to tell game manager when to switch to the game. 
	# For when new run is pressed.
	SignalManager.load_game.connect(_load_game)
	# Used to increase coins on label when coin is collected.
	SignalManager.coin_collected.connect(_increase_coin_amount)
	# Load game is needed to tell game manager when to switch to the game. 
	# For when upgrades is pressed.
	SignalManager.load_skill_tree.connect(_load_skill_tree)
	# All used to apply upgrade effects into permanent stats.
	SignalManager.increase_max_health_permanent.connect(_increase_max_health_permanent)
	SignalManager.increase_extra_coin_chance.connect(_increase_extra_coin_chance)
	SignalManager.increase_damage_permanent.connect(_increase_damage_permanent)
	# Used to get new coin value after max hp is bought.
	SignalManager.update_total_coins.connect(_update_total_coins)
	# Load game is needed to tell game manager when to switch to the game. 
	# For when boss is defeated.
	SignalManager.boss_died.connect(_load_win_screen)
	


# Calculates the new damage cost and apllies the upgrade.
func _increase_damage_permanent():
	damage_cost = (
		(DAMAGE_BASE_COST * BASE_COST_SCALE) 
		+ DAMAGE_BASE_COST * (1 - 0.5 ** (damage_level - 1))
	)
	enemy_damage_take += 1
	# Increases damage level to make next upgrade more expensive.
	damage_level += 1


# Calaculates the new extra coin cost and apllies the upgrade.
func _increase_extra_coin_chance():
	extra_coin_upgrade_cost = (EXTRA_COIN_BASE_COST * (
			(1 + MULTIPLICATIVE_COST_SCALING_VALUE * extra_coin_level) 
			* (EXPONENTIAL_COST_SCALING_VALUE ** extra_coin_level))
		)
	second_coin_chance += EXTRA_COIN_CHANCE_INCREASE_VALUE
	# Increases extra coin level to make next upgrade more expensive.
	extra_coin_level += 1


# Calaculates the new max health cost and apllies the upgrade.
func _increase_max_health_permanent():
	max_hp_cost = (MAX_HP_BASE_COST 
	* (1 + MULTIPLICATIVE_COST_SCALING_VALUE * max_hp_level) 
	* (EXPONENTIAL_COST_SCALING_VALUE ** max_hp_level)
	)
	max_hp += MAX_HP_INCREASE_VALUE
	# Increases max hp level to make next upgrade more expensive.
	max_hp_level += 1


# UIsed to calculate new total coins when max hp upgrade is bought.
func _update_total_coins():
	total_coins -= max_hp_cost


# Used to change scene to skill tree when upgrades button is pressed.
func _load_skill_tree():
	get_tree().change_scene_to_packed(SKILL_TREE)


# Used to change scene to the game scene when new run button is pressed.
func _load_game():
	get_tree().change_scene_to_packed(GAME)


# Used to change scene to the win screen when boss is defeated.
func _load_win_screen():
	get_tree().change_scene_to_packed(WIN_SCREEN)


# Used to add coins to the coin label displayed when a run is happening.
func _increase_coin_amount():
	coins_from_run += 1

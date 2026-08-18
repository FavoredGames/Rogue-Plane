extends Node


const GAME: PackedScene = preload("res://scenes/main.tscn")
const SKILL_TREE: PackedScene = preload("res://scenes/skill_tree.tscn")
var max_hp_cost: int = 1
var damage_cost: int = 10
var total_coins: int = 1
var coins_from_run = 0
var max_hp: int = 4
var enemy_damage_take: int = 1
var extra_coin_upgrade_cost: int = 5
var second_coin_chance = 0.1
var damage_button_disabled: bool = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalManager.load_game.connect(load_game)
	SignalManager.coin_collected.connect(increase_coin_amount)
	SignalManager.load_skill_tree.connect(load_skill_tree)
	SignalManager.increase_max_health_permanent.connect(increase_max_health_permanent)
	SignalManager.update_total_coins.connect(update_total_coins)
	SignalManager.increase_extra_coin_chance.connect(increase_extra_coin_chance)
	SignalManager.increase_damage_permanent.connect(increase_damage_permanent)


func increase_damage_permanent():
	damage_cost += 5
	print("damage cost", damage_cost)
	enemy_damage_take += 1
	


func update_total_coins():
	total_coins -= max_hp_cost


func increase_extra_coin_chance():
	print("extra_coin_upgrade_cost", extra_coin_upgrade_cost)
	extra_coin_upgrade_cost *= 5
	second_coin_chance += 0.1


func increase_max_health_permanent():
	max_hp_cost *= 2
	print("maxhpcost", max_hp_cost)
	max_hp += 3
	


func load_skill_tree():
	get_tree().change_scene_to_packed(SKILL_TREE)
	



func load_game():
	get_tree().change_scene_to_packed(GAME)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass




func increase_coin_amount():
	coins_from_run += 1
	

extends Node


const GAME: PackedScene = preload("res://scenes/main.tscn")
const SKILL_TREE: PackedScene = preload("res://scenes/skill_tree.tscn")
var max_hp_cost: int = 1
var total_coins: int = 1
var coins_from_run = 0
var max_hp: int = 4
var extra_coin_upgrade_cost: int = 5
var second_coin_chance = 0.7

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalManager.load_game.connect(load_game)
	SignalManager.coin_collected.connect(increase_coin_amount)
	SignalManager.load_skill_tree.connect(load_skill_tree)
	SignalManager.increase_max_health_permanent.connect(increase_max_health_permanent)
	SignalManager.update_total_coins.connect(update_total_coins)
	SignalManager.increase_extra_coin_chance.connect(increase_extra_coin_chance)


func update_total_coins():
	total_coins -= max_hp_cost


func increase_extra_coin_chance():
	extra_coin_upgrade_cost *= 2
	print("extra_coin_upgrade_cost", extra_coin_upgrade_cost)
	extra_coin_upgrade_cost += 3


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
	

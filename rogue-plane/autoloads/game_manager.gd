extends Node


const GAME: PackedScene = preload("res://scenes/main.tscn")
const SKILL_TREE: PackedScene = preload("res://scenes/skill_tree.tscn")
var max_hp_cost: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalManager.load_game.connect(load_game)
	SignalManager.coin_collected.connect(increase_coin_amount)
	SignalManager.load_skill_tree.connect(load_skill_tree)
	SignalManager.update_max_hp_cost.connect(update_max_hp_cost)



func update_max_hp_cost():
	max_hp_cost *= 2
	print(max_hp_cost)


func load_skill_tree():
	get_tree().change_scene_to_packed(SKILL_TREE)
	print("FJKFDOBJP")



func load_game():
	get_tree().change_scene_to_packed(GAME)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


var coins_from_run = 0

func increase_coin_amount():
	coins_from_run += 1
	print("coins", coins_from_run)

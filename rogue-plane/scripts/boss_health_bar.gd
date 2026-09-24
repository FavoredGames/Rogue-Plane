extends ProgressBar

@export var boss: CharacterBody2D

# Gets the boss node so can be used to get boss health.
func _ready() -> void:
	for node in get_tree().get_nodes_in_group("boss"):
		boss = node


# Uses boss health as a percentage of boss max health to be displayed on the health bar.
func update_health_bar():
	if boss in get_tree().get_nodes_in_group("boss"):
		value = boss.health * 100 / boss.max_health
		print(boss.health)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	update_health_bar()
	

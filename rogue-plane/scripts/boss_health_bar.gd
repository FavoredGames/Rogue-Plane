extends ProgressBar

@export var boss: CharacterBody2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


func update_health_bar():
	value = boss.health * 100 / boss.player_max_hp


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	update_health_bar()

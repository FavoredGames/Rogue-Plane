extends ProgressBar

@export var player: CharacterBody2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Calculates player health as a percentage of max health and displays the value in the health bar.
func update_health_bar():
	value = player.health * 100 / player.player_max_hp


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	update_health_bar()

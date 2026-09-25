extends ProgressBar

@export var player: CharacterBody2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Calculates player health as a percentage of max health
# and displays the value in the health bar.
func _update_health_bar():
	value = player.health * 100 / player.player_max_hp


# Keeps the health bar up to date with changes every frame.
func _process(delta: float) -> void:
	_update_health_bar()

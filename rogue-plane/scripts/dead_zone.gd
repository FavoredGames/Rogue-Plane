extends CharacterBody2D
var mouse_position = null
var player_position = get_global_position
var direction: Vector2 = Vector2(0.0, 0.0)
var speed: int = 1000
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	velocity = Vector2(0, 0,)
	mouse_position = get_global_mouse_position()
	var direction = (mouse_position - position)
	velocity =  speed * direction.normalized()
	move_and_slide()

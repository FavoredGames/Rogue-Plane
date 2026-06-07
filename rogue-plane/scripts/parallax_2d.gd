extends Parallax2D

const SCROLL_SPEED: int = 500

@onready var sprite_2d: Sprite2D = $Sprite2D

@export var texture: Texture2D



func _ready() -> void:
	var scale_factor = get_viewport_rect().size.x / texture.get_width()
	sprite_2d.texture = texture
	sprite_2d.scale = Vector2(scale_factor, scale_factor)
	#repeat makes the image infinately repeat
	repeat_size.y = texture.get_height() * scale_factor
	


func _process(delta: float) -> void:
	screen_offset.y += SCROLL_SPEED * delta

	
	
	
func on_plane_died() -> void: 
	set_process(false)

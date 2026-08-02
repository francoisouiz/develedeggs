extends StaticBody2D

# NOTE: This script does not work on AnimatedSprite2Ds.
# 		Additionally, all sprite "frames" need to be evenly spaced on the same row for this to work

@onready var sprite_2d: Sprite2D
@export var sprite_id: int;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sprite_2d = get_node("Sprite2D")
	var sprite_count: int = sprite_2d.hframes
	
	if sprite_id and sprite_id < sprite_count:
		sprite_2d.frame = sprite_id
	else:
		sprite_2d.frame = 0
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

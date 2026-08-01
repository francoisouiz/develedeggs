extends Area2D
class_name Interactable

@onready var sprite: Node2D
var had_material: bool = false

func highlight() -> void:
	get_parent().modulate = Color(1.0, 1.0, 1.0) * 1.5
	

func darken() -> void:
	get_parent().modulate = Color(1.0, 1.0, 1.0)

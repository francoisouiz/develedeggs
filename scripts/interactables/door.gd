extends Area2D
class_name Interactable

@export var prompt: String = "test"

func interact(player: Player) -> void:
	pass
	
func highlight() -> void:
	get_parent().modulate = Color(1.0, 1.0, 1.0) * 1.5

func darken() -> void:
	get_parent().modulate = Color(1.0, 1.0, 1.0)

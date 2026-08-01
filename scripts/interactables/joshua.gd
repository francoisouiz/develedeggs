extends Area2D
class_name InteractableItem

@export var prompt: String = "test"

func interact(player: Player) -> void:
	DialogueManager.show_dialogue_balloon(ResourceLoader.load(Constants.DIALOGUE_PATHS.house_1_postpickup), "start")
	
func highlight() -> void:
	get_parent().modulate = Color(1.0, 1.0, 1.0) * 1.5

func darken() -> void:
	get_parent().modulate = Color(1.0, 1.0, 1.0)

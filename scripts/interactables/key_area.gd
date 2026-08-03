extends Interactable

@onready var bush: StaticBody2D = $"../Interactables/Bush2"

func highlight() -> void:
	bush.modulate = Color(1.0, 1.0, 1.0) * 1.5

func darken() -> void:
	bush.modulate = Color(1.0, 1.0, 1.0)

func interact(player: Player) -> void:
	if not PlayerStats.has_key and PlayerStats.found_key:
		DialogueManager.show_dialogue_balloon(ResourceLoader.load(Constants.DIALOGUE_PATHS.store_get_key), "start")
	else:
		DialogueManager.show_dialogue_balloon(ResourceLoader.load(Constants.DIALOGUE_PATHS.bush), "start")

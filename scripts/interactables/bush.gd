extends Interactable

@onready var bush: StaticBody2D = $".."

func interact(player: Player) -> void:
	DialogueManager.show_dialogue_balloon(ResourceLoader.load(Constants.DIALOGUE_PATHS.bush), "start")

func highlight() -> void:
	modulate = Color(1.0, 1.0, 1.0) * 1.5

func darken() -> void:
	modulate = Color(1.0, 1.0, 1.0)

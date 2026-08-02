extends Interactable

@onready var folded_clothes_3: StaticBody2D = $"../StaticObjects/FoldedClothes3"

func highlight() -> void:
	folded_clothes_3.modulate = Color(1.0, 1.0, 1.0) * 1.5

func darken() -> void:
	folded_clothes_3.modulate = Color(1.0, 1.0, 1.0)

func interact(player: Player) -> void:
	if PlayerStats.can_jacket and not PlayerStats.picked_up_jacket:
		DialogueManager.show_dialogue_balloon(ResourceLoader.load(Constants.DIALOGUE_PATHS.jacket_area), "start")
	else:
		DialogueManager.show_dialogue_balloon(ResourceLoader.load(Constants.DIALOGUE_PATHS.house_1_clothes), "start")

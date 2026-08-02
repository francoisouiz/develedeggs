extends Interactable

@onready var folded_clothes_4: StaticBody2D = $"../StaticObjects/FoldedClothes4"

func highlight() -> void:
	folded_clothes_4.modulate = Color(1.0, 1.0, 1.0) * 1.5

func darken() -> void:
	folded_clothes_4.modulate = Color(1.0, 1.0, 1.0)

func interact(player: Player) -> void:
	if PlayerStats.can_watch and not PlayerStats.picked_up_watch:
		DialogueManager.show_dialogue_balloon(ResourceLoader.load(Constants.DIALOGUE_PATHS.watch_area), "start")
	else:
		DialogueManager.show_dialogue_balloon(ResourceLoader.load(Constants.DIALOGUE_PATHS.house_1_clothes), "start")

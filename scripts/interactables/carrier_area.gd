extends Interactable

@onready var bed: StaticBody2D = $"../StaticObjects/Bed"

func highlight() -> void:
	bed.modulate = Color(1.0, 1.0, 1.0) * 1.5

func darken() -> void:
	bed.modulate = Color(1.0, 1.0, 1.0)

func interact(player: Player) -> void:
	if PlayerStats.can_carrier and not PlayerStats.picked_up_carrier:
		DialogueManager.show_dialogue_balloon(ResourceLoader.load(Constants.DIALOGUE_PATHS.carrier_area), "start")
	else:
		DialogueManager.show_dialogue_balloon(ResourceLoader.load(Constants.DIALOGUE_PATHS.house_1_bed), "start")

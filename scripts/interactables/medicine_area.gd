extends Interactable

@onready var medical_bills: StaticBody2D = $"../StaticObjects/MedicalBills"

func highlight() -> void:
	medical_bills.modulate = Color(1.0, 1.0, 1.0) * 1.5

func darken() -> void:
	medical_bills.modulate = Color(1.0, 1.0, 1.0)

func interact(player: Player) -> void:
	if PlayerStats.can_medicine and not PlayerStats.picked_up_medicine:
		DialogueManager.show_dialogue_balloon(ResourceLoader.load(Constants.DIALOGUE_PATHS.medicine_area), "start")
	else:
		DialogueManager.show_dialogue_balloon(ResourceLoader.load(Constants.DIALOGUE_PATHS.medical_bills), "start")

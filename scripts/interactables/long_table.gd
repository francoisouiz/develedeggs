extends Interactable

func interact(player: Player) -> void:
	DialogueManager.show_dialogue_balloon(ResourceLoader.load(Constants.DIALOGUE_PATHS.long_table), "start")

extends Node2D

func _ready() -> void:
	DialogueManager.dialogue_ended.connect(_on_dialogue_ended)
	DialogueManager.show_dialogue_balloon(ResourceLoader.load(Constants.DIALOGUE_PATHS.house_1_start), "start")


func _on_dialogue_ended(resource: DialogueResource) -> void:
	PlayerStats.can_move = true

extends Node

@onready var player: Player = get_tree().get_nodes_in_group(&"Player")[0]
@export var dialogue_resource: DialogueResource
@export var interactable: bool = true


func _process(delta: float) -> void:
	if player.global_position.distance_to(get_parent().global_position) < 100 and interactable:
		get_parent().modulate = Color(1.0, 1.0, 1.0) * 1.5
	else:
		get_parent().modulate = Color(1.0, 1.0, 1.0)

func _input(event: InputEvent) -> void:
	if interactable and event.is_action_pressed("interact"):
		DialogueManager.show_dialogue_balloon(dialogue_resource, "start")

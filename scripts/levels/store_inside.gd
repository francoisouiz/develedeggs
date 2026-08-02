extends Node2D

@onready var player: Player = $Player
@onready var joshua: CharacterBody2D = $Joshua

func _ready() -> void:
	player.entered_photo.connect(on_entered_photo)
	player.exited_photo.connect(on_exited_photo)
	await get_tree().create_timer(1.5).timeout
	DialogueManager.dialogue_ended.connect(on_dialogue_ended)
	DialogueManager.show_dialogue_balloon(ResourceLoader.load(Constants.DIALOGUE_PATHS.store_inside_start), "start")

func on_entered_photo() -> void:
	disable_node(joshua)

func on_exited_photo() -> void:
	enable_node(joshua)
	
func disable_node(node: Node) -> void:
	node.process_mode = 4
	node.hide()

func enable_node(node: Node) -> void:
	node.process_mode = 0
	node.show()
	
func go_to_house_2() -> void:
	pass

func on_dialogue_ended(resource: DialogueResource) -> void:
	if PlayerStats.scene_progress == 0 and PlayerStats.has_food1 and PlayerStats.has_food2 and PlayerStats.has_clothes:
		PlayerStats.continue_scene()
		DialogueManager.show_dialogue_balloon(ResourceLoader.load(Constants.DIALOGUE_PATHS.post_getting), "start")

extends Node2D

@onready var player: Player = $Player
@onready var joshua: CharacterBody2D = $Joshua
@onready var background_music: AudioStreamPlayer2D = $BackgroundMusic

func _ready() -> void:
	player.entered_photo.connect(on_entered_photo)
	player.exited_photo.connect(on_exited_photo)
	await get_tree().create_timer(1.5).timeout
	DialogueManager.dialogue_ended.connect(on_dialogue_ended)
	DialogueManager.show_dialogue_balloon(ResourceLoader.load(Constants.DIALOGUE_PATHS.store_inside_start), "start")

func on_entered_photo() -> void:
	disable_node(joshua)
	background_music.pitch_scale = 0.6

func on_exited_photo() -> void:
	enable_node(joshua)
	background_music.pitch_scale = 1
	
func disable_node(node: Node) -> void:
	node.process_mode = 4
	node.hide()

func enable_node(node: Node) -> void:
	node.process_mode = 0
	node.show()
	
func go_to_house_2() -> void:
	PlayerStats.curr_level = "messy_house"
	SceneLoader.load_scene(Constants.SCENE_PATHS.house_2)

func on_dialogue_ended(resource: DialogueResource) -> void:
	if PlayerStats.scene_progress == 0 and PlayerStats.has_food1 and PlayerStats.has_food2 and PlayerStats.has_clothes:
		print(PlayerStats.scene_progress)
		PlayerStats.continue_scene()
		DialogueManager.show_dialogue_balloon(ResourceLoader.load(Constants.DIALOGUE_PATHS.post_getting), "start")

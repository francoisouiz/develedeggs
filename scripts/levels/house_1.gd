extends Node2D

@onready var doorbell: AudioStreamPlayer2D = $Doorbell
@onready var cat_audio: AudioStreamPlayer2D = $Cat
@onready var package: AudioStreamPlayer2D = $Package
@onready var background_music: AudioStreamPlayer2D = $BackgroundMusic
@onready var instruction: Label = $Instruction
@onready var player: Player = $Player
@onready var folded_clothes: StaticBody2D = $StaticObjects/FoldedClothes
@onready var duffle_bag: StaticBody2D = $Interactable/DuffleBag
@onready var cat: StaticBody2D = $Interactable/Cat
@onready var martin: CharacterBody2D = $Martin
@onready var joshua: CharacterBody2D = $Joshua
@onready var bookshelf_horizontal: StaticBody2D = $StaticObjects/BookshelfHorizontal
@onready var bookshelf_horizontal_2: StaticBody2D = $StaticObjects/BookshelfHorizontal2
@onready var console: StaticBody2D = $StaticObjects/Console
var loading_screen: PackedScene = preload(Constants.SCENE_PATHS.loading_screen)

signal queso_finished
signal load_finished

func _ready() -> void:
	disable_node(console)
	instruction.hide()
	DialogueManager.dialogue_ended.connect(on_dialogue_ended)
	player.entered_photo.connect(on_entered_photo)
	player.exited_photo.connect(on_exited_photo)
	await get_tree().create_timer(3.0).timeout
	DialogueManager.show_dialogue_balloon(ResourceLoader.load(Constants.DIALOGUE_PATHS.house_1_start), "start")
	
func play_doorbell() -> void:
	doorbell.play()
	await doorbell.finished

func play_cat() -> void:
	background_music.volume_db = -6.7
	cat_audio.play()
	await cat_audio.finished 
	background_music.volume_db = 0
	
func play_package() -> void:
	package.play()
	await package.finished
	
func show_instruction() -> void:
	instruction.show()

func house_wait() -> void:
	await get_tree().create_timer(2.0).timeout
	
func on_entered_photo() -> void:
	instruction.hide()
	disable_node(folded_clothes)
	disable_node(duffle_bag)
	disable_node(cat)
	disable_node(bookshelf_horizontal)
	disable_node(bookshelf_horizontal_2)
	enable_node(console)
	joshua.global_position = Vector2(100, 110)
	martin.global_position = Vector2(95, 84)
	background_music.pitch_scale = 0.6
	
func on_exited_photo() -> void:
	instruction.hide()
	enable_node(folded_clothes)
	enable_node(duffle_bag)
	enable_node(cat)
	enable_node(bookshelf_horizontal)
	enable_node(bookshelf_horizontal_2)
	disable_node(console)
	joshua.global_position = Vector2(166, 103)
	martin.global_position = Vector2(188, 102)
	background_music.pitch_scale = 1

func disable_node(node: Node) -> void:
	node.process_mode = 4
	node.hide()

func enable_node(node: Node) -> void:
	node.process_mode = 0
	node.show()
	
func people_leave() -> void:
	var new_load_screen: CanvasLayer = loading_screen.instantiate()
	add_child(new_load_screen)
	await new_load_screen.loading_screen_ready
	disable_node(joshua)
	disable_node(martin)
	load_finished.connect(new_load_screen._on_load_finished)
	load_finished.emit()
	
func go_to_store() -> void:
	SceneLoader.load_scene(Constants.SCENE_PATHS.main_menu)
	
func on_dialogue_ended(resource: DialogueResource) -> void:
	if PlayerStats.scene_progress == 1 and PlayerStats.bed_interacted and PlayerStats.has_talked_house and PlayerStats.console_interacted and PlayerStats.calendar_interacted:
		PlayerStats.continue_scene()
		DialogueManager.show_dialogue_balloon(ResourceLoader.load(Constants.DIALOGUE_PATHS.realization), "start")

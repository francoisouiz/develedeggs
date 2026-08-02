extends Node2D

@onready var cat: StaticBody2D = $Interactable/Cat
@onready var player: Player = $Player
@onready var book_1: Sprite2D = $StaticObjects/BookshelfHorizontal/Sprite2D
@onready var book_2: Sprite2D = $StaticObjects/BookshelfHorizontal2/Sprite2D
@onready var background_music: AudioStreamPlayer2D = $BackgroundMusic
@onready var bed: StaticBody2D = $StaticObjects/Bed
@onready var photo_bed: StaticBody2D = $StaticObjects/PhotoBed
@onready var console: StaticBody2D = $StaticObjects/Console
@onready var folded_clothes: StaticBody2D = $StaticObjects/FoldedClothes
@onready var folded_clothes_2: StaticBody2D = $StaticObjects/FoldedClothes2
@onready var folded_clothes_4: StaticBody2D = $StaticObjects/FoldedClothes4
@onready var folded_clothes_3: StaticBody2D = $StaticObjects/FoldedClothes3
@onready var folded_clothes_5: StaticBody2D = $StaticObjects/FoldedClothes5
@onready var books: StaticBody2D = $StaticObjects/Books
@onready var books_2: StaticBody2D = $StaticObjects/Books2
@onready var books_3: StaticBody2D = $StaticObjects/Books3
@onready var single_book: StaticBody2D = $StaticObjects/SingleBook
@onready var single_book_2: StaticBody2D = $StaticObjects/SingleBook2
@onready var medical_bills: StaticBody2D = $StaticObjects/MedicalBills
@onready var duffle_bag: StaticBody2D = $Interactable/DuffleBag
@onready var canvas_anim: AnimationPlayer = $CanvasModulate/CanvasAnim
@onready var watch_anim: AnimationPlayer = $WatchCloseup/WatchAnim
@onready var watch_area: Interactable = $WatchArea
@onready var carrier_area: Area2D = $CarrierArea
@onready var jacket_area: Interactable = $JacketArea
@onready var medicine_area: Interactable = $MedicineArea
@onready var medicine_anim: AnimationPlayer = $MedicineCloseup/MedicineAnim
@onready var jacket_anim: AnimationPlayer = $JacketCloseup/JacketAnim
@onready var carrier_anim: AnimationPlayer = $CarrierCloseup/CarrierAnim

@onready var removables: Array[StaticBody2D] = [cat, bed, folded_clothes, folded_clothes_2, folded_clothes_3, folded_clothes_4, folded_clothes_5, books, books_2, books_3, single_book, single_book_2, duffle_bag, medical_bills]
@onready var areas: Array[Interactable] = [watch_area, medicine_area, jacket_area, carrier_area]

func _ready() -> void:
	cat.get_node("AnimatedSprite2D").play("seated")
	PlayerStats.scene_progress = 0
	disable_node(console)
	disable_node(photo_bed)
	player.entered_photo.connect(on_entered_photo)
	player.exited_photo.connect(on_exited_photo)
	await get_tree().create_timer(1.5).timeout
	DialogueManager.dialogue_ended.connect(on_dialogue_ended)
	DialogueManager.show_dialogue_balloon(ResourceLoader.load(Constants.DIALOGUE_PATHS.house_2_start), "start")
	
func on_entered_photo() -> void:
	book_1.frame = 2
	book_2.frame = 2
	for node: StaticBody2D in removables:
		disable_node(node)
	for interactable: Interactable in areas:
		disable_node(interactable)
	enable_node(console)
	enable_node(photo_bed)
	background_music.pitch_scale = 0.6

func on_exited_photo() -> void:
	book_1.frame = 1
	book_2.frame = 0
	for node: StaticBody2D in removables:
		enable_node(node)
	for interactable: Interactable in areas:
		enable_node(interactable)
	disable_node(console)
	disable_node(photo_bed)
	background_music.pitch_scale = 1
	
func play_watch() -> void:
	canvas_anim.play("canvas_anim")
	watch_anim.play("watch_transition")
	await watch_anim.animation_finished
	await get_tree().create_timer(1.0).timeout
	canvas_anim.play_backwards("canvas_anim")
	watch_anim.play_backwards()
	await watch_anim.animation_finished

func play_medicine() -> void:
	canvas_anim.play("canvas_anim")
	medicine_anim.play("watch_transition")
	await medicine_anim.animation_finished
	await get_tree().create_timer(1.0).timeout
	canvas_anim.play_backwards("canvas_anim")
	medicine_anim.play_backwards()
	await medicine_anim.animation_finished

func play_jacket() -> void:
	canvas_anim.play("canvas_anim")
	jacket_anim.play("watch_transition")
	await jacket_anim.animation_finished
	await get_tree().create_timer(1.0).timeout
	canvas_anim.play_backwards("canvas_anim")
	jacket_anim.play_backwards()
	await jacket_anim.animation_finished

func play_carrier() -> void:
	canvas_anim.play("canvas_anim")
	carrier_anim.play("watch_transition")
	await carrier_anim.animation_finished
	await get_tree().create_timer(1.0).timeout
	canvas_anim.play_backwards("canvas_anim")
	carrier_anim.play_backwards()
	await carrier_anim.animation_finished
	
func disable_node(node: Node) -> void:
	node.process_mode = 4
	node.hide()

func enable_node(node: Node) -> void:
	node.process_mode = 0
	node.show()

func go_to_province() -> void:
	PlayerStats.curr_level = "province"
	SceneLoader.load_scene(Constants.SCENE_PATHS.province)
	
func on_dialogue_ended(dialogue: DialogueResource) -> void:
	if PlayerStats.scene_progress == 0 and PlayerStats.picked_up_carrier and PlayerStats.picked_up_jacket and PlayerStats.picked_up_medicine and PlayerStats.picked_up_watch:
		DialogueManager.show_dialogue_balloon(ResourceLoader.load(Constants.DIALOGUE_PATHS.house_2_end), "start")

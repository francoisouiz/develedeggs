extends Node2D

@onready var player: Player = $Player
@onready var dining_chair: StaticBody2D = $StaticObjects/DiningChair
@onready var dining_chair_2: StaticBody2D = $StaticObjects/DiningChair2
@onready var dining_chair_3: StaticBody2D = $StaticObjects/DiningChair3
@onready var dining_chair_5: StaticBody2D = $StaticObjects/DiningChair5
@onready var dining_chair_6: StaticBody2D = $StaticObjects/DiningChair6
@onready var long_table: StaticBody2D = $StaticObjects/LongTable
@onready var dining_chair_4: StaticBody2D = $StaticObjects/DiningChair4
@onready var cabinet: StaticBody2D = $StaticObjects/Cabinet
@onready var refrigerator: StaticBody2D = $StaticObjects/Refrigerator
@onready var bookshelf_vertical: StaticBody2D = $StaticObjects/BookshelfVertical
@onready var round_table: StaticBody2D = $StaticObjects/RoundTable
@onready var bibingka: Sprite2D = $StaticObjects/Bibingka
@onready var puto_bumbong: Sprite2D = $StaticObjects/PutoBumbong
@onready var puto_bumbong_3: Sprite2D = $StaticObjects/PutoBumbong3
@onready var puto_bumbong_2: Sprite2D = $StaticObjects/PutoBumbong2
@onready var leather_jacket: Sprite2D = $StaticObjects/LeatherJacket
@onready var transition_anim: AnimationPlayer = $Panel2/TransitionAnim
@onready var tito_elpa: CharacterBody2D = $TitoElpa
@onready var player_anim: AnimatedSprite2D = $Player/AnimatedSprite2D

@onready var removables: Array[StaticBody2D] = [dining_chair, dining_chair_2, dining_chair_3, dining_chair_5, dining_chair_6, dining_chair_4, long_table, cabinet, refrigerator, bookshelf_vertical, round_table]
@onready var pasalubongs: Array[Sprite2D] = [bibingka, puto_bumbong_3, puto_bumbong, puto_bumbong_2, leather_jacket]

func _ready() -> void:
	PlayerStats.scene_progress = 0
	player.entered_photo.connect(on_entered_photo)
	player.exited_photo.connect(on_exited_photo)
	DialogueManager.dialogue_ended.connect(on_dialogue_ended)
	DialogueManager.show_dialogue_balloon(ResourceLoader.load(Constants.DIALOGUE_PATHS.province_start), "start")
	disable_node(tito_elpa)
	for node: Node in removables:
		disable_node(node)
	for pasalubong: Sprite2D in pasalubongs:
		disable_node(pasalubong)

func on_entered_photo() -> void:
	for node: Node in removables:
		enable_node(node)

func on_exited_photo() -> void:
	for node: Node in removables:
		disable_node(node)

func pick_up_items() -> void:
	transition_anim.play("transition_anim")
	await transition_anim.animation_finished
	for pasalubong: Sprite2D in pasalubongs:
		disable_node(pasalubong)
	transition_anim.play_backwards("transition_anim")
	await transition_anim.animation_finished
	province_wait()
	PlayerStats.has_placed_puto = false
	PlayerStats.has_placed_jacket = false
	PlayerStats.has_placed_bibingka = false

func add_tito() -> void:
	transition_anim.play("transition_anim")
	await transition_anim.animation_finished
	enable_node(tito_elpa)
	player.position = Vector2(162, 76)
	player_anim.play("idle cam")
	player_anim.flip_h = true
	transition_anim.play_backwards("transition_anim")
	await transition_anim.animation_finished
	province_wait()

func kill_tito() -> void:
	transition_anim.play("transition_anim")
	await transition_anim.animation_finished
	disable_node(tito_elpa)
	transition_anim.play_backwards("transition_anim")
	await transition_anim.animation_finished

func province_wait() -> void:
	await get_tree().create_timer(2.0).timeout
	
func go_to_cemetery() -> void:
	PlayerStats.curr_level = "cemetery"
	SceneLoader.load_scene(Constants.SCENE_PATHS.cemetery)

func show_sprite(name: String) -> void:
	match name:
		"jacket":
			enable_node(leather_jacket)
		"puto":
			enable_node(puto_bumbong)
			enable_node(puto_bumbong_2)
			enable_node(puto_bumbong_3)
		"bibingka":
			enable_node(bibingka)

func disable_node(node: Node) -> void:
	node.process_mode = 4
	node.hide()

func enable_node(node: Node) -> void:
	node.process_mode = 0
	node.show()

func on_dialogue_ended(resource: DialogueResource) -> void:
	if PlayerStats.scene_progress == 1 and PlayerStats.has_placed_bibingka and PlayerStats.has_placed_jacket and PlayerStats.has_placed_puto:
		PlayerStats.continue_scene()
		DialogueManager.show_dialogue_balloon(ResourceLoader.load(Constants.DIALOGUE_PATHS.first_enter_end), "start")
	if PlayerStats.scene_progress == 4 and PlayerStats.has_placed_bibingka and PlayerStats.has_placed_jacket and PlayerStats.has_placed_puto:
		PlayerStats.continue_scene()
		DialogueManager.show_dialogue_balloon(ResourceLoader.load(Constants.DIALOGUE_PATHS.second_enter_end), "start")

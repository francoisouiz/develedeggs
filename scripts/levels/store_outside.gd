extends Node2D

@onready var background_music: AudioStreamPlayer2D = $BackgroundMusic
@onready var player: Player = $Player

# INTERACTABLES
@onready var key_area: Area2D = $KeyArea
@onready var bush_2: StaticBody2D = $Interactables/Bush2
@onready var key: StaticBody2D = $HiddenObjects/Key
@onready var joshua: CharacterBody2D = $Joshua
@onready var store_building: StaticBody2D = $Interactables/StoreBuilding
@onready var point_light_2d: PointLight2D = $Lights/PointLight2D
@onready var point_light_2d_2: PointLight2D = $Lights/PointLight2D2
@onready var point_light_2d_3: PointLight2D = $Lights/PointLight2D3
@onready var point_light_2d_4: PointLight2D = $Lights/PointLight2D4
@onready var canvas_anim: AnimationPlayer = $CanvasModulate/CanvasAnim
@onready var key_anim: AnimationPlayer = $Key/KeyAnim

@onready var removables : Array[StaticBody2D] = [bush_2]
@onready var hiddens : Array[StaticBody2D] = [key]
@onready var areas : Array[Area2D] = [key_area]

func _ready() -> void:
	PlayerStats.can_move = false
	PlayerStats.scene_progress = 0
	player.entered_photo.connect(on_entered_photo)
	player.exited_photo.connect(on_exited_photo)
	disable_node(point_light_2d_3)
	disable_node(point_light_2d_4)
	
	#disable_node()
	for node : StaticBody2D in hiddens:
		disable_node(node)
	
	await get_tree().create_timer(1.5).timeout
	
	DialogueManager.show_dialogue_balloon(ResourceLoader.load(Constants.DIALOGUE_PATHS.store_outside_start), "start")

func store_wait() -> void:
	await get_tree().create_timer(1.5).timeout

func play_key() -> void:
	canvas_anim.play("canvas_anim")
	key_anim.play("watch_transition")
	await key_anim.animation_finished
	await get_tree().create_timer(1.0).timeout
	canvas_anim.play_backwards("canvas_anim")
	key_anim.play_backwards()
	await key_anim.animation_finished
	
func on_entered_photo() -> void:
	if PlayerStats.scene_progress == 0:
		DialogueManager.show_dialogue_balloon(ResourceLoader.load(Constants.DIALOGUE_PATHS.store_past), "start")
	
	for node: StaticBody2D in removables:
		disable_node(node)
	disable_node(joshua)
	for interactable: Interactable in areas:
		disable_node(interactable)
	for node : StaticBody2D in hiddens:
		enable_node(node)
	disable_node(point_light_2d)
	disable_node(point_light_2d_2)
	enable_node(point_light_2d_3)
	enable_node(point_light_2d_4)
		
	store_building.switch_form("old")
	
	
	
	background_music.pitch_scale = 0.6

func on_exited_photo() -> void:
	for node: StaticBody2D in removables:
		enable_node(node)
	enable_node(joshua)
	for interactable: Interactable in areas:
		enable_node(interactable)
	for node : StaticBody2D in hiddens:
		disable_node(node)
		
	enable_node(point_light_2d)
	enable_node(point_light_2d_2)
	disable_node(point_light_2d_3)
	disable_node(point_light_2d_4)
	
	store_building.switch_form("new")
	
	background_music.pitch_scale = 1

func disable_node(node: Node) -> void:
	node.process_mode = 4
	node.hide()

func enable_node(node: Node) -> void:
	node.process_mode = 0
	node.show()

func go_to_store_inside() -> void:
	PlayerStats.curr_level = "store_inside"
	SceneLoader.load_scene(Constants.SCENE_PATHS.store_inside)

func pickup_key() -> void:
	key.queue_free()
	hiddens.pop_front()
	PlayerStats.has_key = true

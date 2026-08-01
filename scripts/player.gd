extends CharacterBody2D
class_name Player

signal entered_photo
signal exited_photo
signal load_finished

const speed: float = 60
@onready var photo_film: PhotoFilm = $"../PhotoFilmTexture"
@onready var interactable_area: Area2D = $InteractableArea
@onready var label: Label = $Label
@onready var camera: AudioStreamPlayer2D = $Camera
@onready var house_1: Node2D = $".."
var loading_screen: PackedScene = preload(Constants.SCENE_PATHS.loading_screen)
var nearby_interactables: Array[Interactable] = []
var target: Interactable = null


func _ready() -> void:
	add_to_group(&"Player")
	label.hide()
	#house_1.queso_finished.connect(on_queso_finished)
	
func _physics_process(_delta: float) -> void:
	get_nearest_interactable()
	if target:
		label.show()
		target.highlight()
	if PlayerStats.can_move:
		get_input()
	move_and_slide()

func get_input() -> void:
	var input_direction: Vector2 = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = input_direction * speed
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("flip_photo") and PlayerStats.can_move and PlayerStats.can_photo:
		print(PlayerStats.scene_progress)
		if PlayerStats.curr_level == "start" and PlayerStats.scene_progress == 0:
			return
		elif PlayerStats.curr_level == "start" and PlayerStats.scene_progress == 1:
			PlayerStats.can_photo = false
			DialogueManager.show_dialogue_balloon(ResourceLoader.load(Constants.DIALOGUE_PATHS.queso), "start")
		elif PlayerStats.curr_level == "start" and PlayerStats.scene_progress == 2 and not PlayerStats.post_photo_played:
			flash()
			DialogueManager.show_dialogue_balloon(ResourceLoader.load(Constants.DIALOGUE_PATHS.post_photo), "start")
		else:
			flash()
				
	if event.is_action_pressed("interact") and PlayerStats.can_move:
		if target:
			target.interact(self)
		# ChangeTileset

func get_nearest_interactable() -> void:
	if target:
		if target not in nearby_interactables:
			target.darken()
			label.hide()
			target = null
		return
	
	var nearest: Interactable = null
	var min_distance: float = INF
	
	for interactable: Interactable in nearby_interactables:
		var distance: float = global_position.distance_to(interactable.global_position)
		if distance < min_distance:
			min_distance = distance
			nearest = interactable
	target = nearest

func on_queso_finished() -> void:
	flash()

func flash() -> void:
	camera.play()
	var new_load_screen: CanvasLayer = loading_screen.instantiate()
	add_child(new_load_screen)
	await new_load_screen.loading_screen_ready
	load_finished.connect(new_load_screen._on_load_finished)
	load_finished.emit()
	
	match PlayerStats.in_photo:
		true:
			photo_film.hide()
			PlayerStats.in_photo = false
			exited_photo.emit()
		false:
			photo_film.show()
			PlayerStats.in_photo = true
			entered_photo.emit()

func _on_interactable_area_area_entered(area: Area2D) -> void:
	if area is Interactable:
		nearby_interactables.append(area)

func _on_interactable_area_area_exited(area: Area2D) -> void:
	if area is Interactable:
		nearby_interactables.erase(area)

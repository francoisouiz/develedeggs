extends CharacterBody2D
class_name Player

const speed: float = 60
# @onready var photo_film: PhotoFilm = $"../PhotoFilmTexture2"
@onready var interactable_area: Area2D = $InteractableArea
var nearby_interactables: Array[Interactable] = []
var target: Interactable = null

func _ready() -> void:
	add_to_group(&"Player")
	
func _physics_process(_delta: float) -> void:
	get_nearest_interactable()
	if target:
		target.highlight()
	if PlayerStats.can_move:
		get_input()
	move_and_slide()

func get_input() -> void:
	var input_direction: Vector2 = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = input_direction * speed
	
func _input(event: InputEvent) -> void:
	#if event.is_action_pressed("flip_photo") and PlayerStats.can_move:
		#match PlayerStats.in_photo:
			#true:
				#photo_film.hide()
				#PlayerStats.in_photo = false
			#false:
				#photo_film.show()
				#PlayerStats.in_photo = true
	if event.is_action_pressed("interact") and PlayerStats.can_move:
		if target:
			target.interact(self)
		# ChangeTileset

func get_nearest_interactable() -> void:
	if target:
		if target not in nearby_interactables:
			target.darken()
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

func _on_interactable_area_area_entered(area: Area2D) -> void:
	if area is Interactable:
		nearby_interactables.append(area)

func _on_interactable_area_area_exited(area: Area2D) -> void:
	if area is Interactable:
		nearby_interactables.erase(area)

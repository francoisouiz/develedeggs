extends CharacterBody2D
class_name Player

const speed: float = 60
@onready var photo_film: PhotoFilm = $"../PhotoFilmTexture2"

func _ready() -> void:
	add_to_group(&"Player")
	
func _physics_process(_delta: float) -> void:
	get_input()
	move_and_slide()

func get_input() -> void:
	var input_direction: Vector2 = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = input_direction * speed
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("FlipPhoto") and PlayerStats.can_move:
		match PlayerStats.in_photo:
			true:
				photo_film.hide()
				PlayerStats.in_photo = false
			false:
				photo_film.show()
				PlayerStats.in_photo = true
		# ChangeTileset

extends CharacterBody2D
class_name Player

@onready var photo_film: PhotoFilm = $"../PhotoFilmTexture2"
const speed: float = 300.0

func _ready() -> void:
	add_to_group(&"Player")

func _physics_process(delta: float) -> void:
	var direction_hor: float = Input.get_axis("ui_left", "ui_right")
	if direction_hor and PlayerStats.can_move:
		velocity.x = direction_hor * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		
	var direction_vert: float = Input.get_axis("ui_up", "ui_down")
	if direction_vert and PlayerStats.can_move:
		velocity.y = direction_vert * speed
	else:
		velocity.y = move_toward(velocity.y, 0, speed)

	move_and_slide()
	
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

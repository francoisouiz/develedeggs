extends CharacterBody2D
class_name Player

const speed: float = 60

func _ready() -> void:
	add_to_group(&"Player")
	
func _physics_process(_delta: float) -> void:
	get_input()
	move_and_slide()

func get_input() -> void:
	var input_direction: Vector2 = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = input_direction * speed

extends Interactable

@onready var animated_sprite_2d: AnimatedSprite2D = $"../AnimatedSprite2D"

func _ready() -> void:
	animated_sprite_2d.play()

func interact(player: Player) -> void:
	DialogueManager.show_dialogue_balloon(ResourceLoader.load(Constants.DIALOGUE_PATHS.house_1_cat), "start")

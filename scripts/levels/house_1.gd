extends Node2D

@onready var doorbell: AudioStreamPlayer2D = $Doorbell

func _ready() -> void:
	await get_tree().create_timer(2.0).timeout
	DialogueManager.show_dialogue_balloon(ResourceLoader.load(Constants.DIALOGUE_PATHS.house_1_start), "start")

func play_doorbell() -> void:
	doorbell.play()
	await doorbell.finished

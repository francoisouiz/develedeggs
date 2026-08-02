extends Node2D

@onready var player: Player = $Player
@onready var player_sprite: AnimatedSprite2D = $Player/AnimatedSprite2D
@onready var walking_animation: AnimationPlayer = $Player/WalkingPathAnimation

@onready var transition_anim: AnimationPlayer = $Panel2/TransitionAnim

func _ready() -> void:
	DialogueManager.dialogue_ended.connect(on_dialogue_ended)
	DialogueManager.show_dialogue_balloon(ResourceLoader.load(Constants.DIALOGUE_PATHS.cemetery), "start")
	

func walk_away() -> void:
	player_sprite.flip_h = true
	
	await get_tree().create_timer(1).timeout
	
	player_sprite.play("walking no cam")
	
	
	walking_animation.animation_finished.connect(_on_walk_finish)
	walking_animation.play("walk_away")
	
func on_dialogue_ended(resource: DialogueResource) -> void:
	PlayerStats.can_move = false
	walk_away()

func _on_walk_finish(anim_name: String) ->void:
	print("fin")

func quick_dim(dim_duration: float) -> void:
	transition_anim.play("transition_anim")
	await transition_anim.animation_finished
	
	await get_tree().create_timer(dim_duration).timeout
	
	transition_anim.play_backwards("transition_anim")
	await transition_anim.animation_finished

func place_photos() -> void:
	print("photos placed")
	await quick_dim(1.0)

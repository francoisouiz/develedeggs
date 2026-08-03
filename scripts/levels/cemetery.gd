extends Node2D

@onready var player: Player = $Player
@onready var player_sprite: AnimatedSprite2D = $Player/AnimatedSprite2D
@onready var walking_animation: AnimationPlayer = $Player/WalkingPathAnimation

@onready var photo_stack: Node2D = $PhotoStack

@onready var transition_anim: AnimationPlayer = $Panel2/TransitionAnim

func _ready() -> void:
	await get_tree().create_timer(1.5).timeout
	
	DialogueManager.dialogue_ended.connect(on_dialogue_ended)
	DialogueManager.show_dialogue_balloon(ResourceLoader.load(Constants.DIALOGUE_PATHS.cemetery), "start")
	

func walk_away() -> void:
	player_sprite.flip_h = true
	
	await get_tree().create_timer(1).timeout
	
	player_sprite.play("walking cam")
	walking_animation.play("walk_away")
	# call play_credits

func play_credits() -> void:
	pass
	# play credits
	# await credits
	# play fadeout
	# await fadeout
	# call go back_menu
	
func on_dialogue_ended(resource: DialogueResource) -> void:
	PlayerStats.can_move = false
	walk_away()

func go_back_menu() ->void:
	PlayerStats.curr_level = ""
	SceneLoader.load_scene(Constants.SCENE_PATHS.main_menu)

func quick_dim(dim_duration: float) -> void:
	transition_anim.play("transition_anim")
	await transition_anim.animation_finished
	
	await get_tree().create_timer(dim_duration).timeout
	
	transition_anim.play_backwards("transition_anim")
	await transition_anim.animation_finished

func place_photo() -> void:
	player_sprite.play("place down")
	photo_stack.reveal_photo()
	await get_tree().create_timer(0.5).timeout

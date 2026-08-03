extends Node2D

@onready var player: Player = $Player
@onready var player_sprite: AnimatedSprite2D = $Player/AnimatedSprite2D
@onready var walking_animation: AnimationPlayer = $Player/WalkingPathAnimation

@onready var photo_stack: Node2D = $PhotoStack

@onready var transition_anim: AnimationPlayer = $Panel2/TransitionAnim

@onready var title_animation: AnimationPlayer = $Control/TextureRect/TitleAnimation
@onready var progarmmers_animation: AnimationPlayer = $Control/Label/ProgarmmersAnimation
@onready var arts_animation: AnimationPlayer = $Control/Label2/ArtsAnimation
@onready var soundtrack_animation: AnimationPlayer = $Control/Label3/SoundtrackAnimation
@onready var voice_animation: AnimationPlayer = $Control/Label4/VoiceAnimation
@onready var stock_animation_1: AnimationPlayer = $Control/Label5/StockAnimation1
@onready var stock_animation_2: AnimationPlayer = $Control/Label6/StockAnimation2
@onready var script_animation: AnimationPlayer = $Control/Label7/ScriptAnimation

@onready var credit_animations: Array[AnimationPlayer] = [
	title_animation, progarmmers_animation, script_animation,
	arts_animation, soundtrack_animation,
	voice_animation, stock_animation_1, stock_animation_2
]

func _ready() -> void:
	await get_tree().create_timer(1.5).timeout
	
	DialogueManager.dialogue_ended.connect(on_dialogue_ended)
	DialogueManager.show_dialogue_balloon(ResourceLoader.load(Constants.DIALOGUE_PATHS.cemetery), "start")
	

func walk_away() -> void:
	player_sprite.flip_h = true
	
	await get_tree().create_timer(1).timeout
	
	player_sprite.play("walking cam")
	walking_animation.play("walk_away")
	
	await walking_animation.animation_finished
	play_credits()

func play_credits() -> void:
	await get_tree().create_timer(2.0).timeout
	
	for animation: AnimationPlayer in credit_animations:
		animation.play("fade_inout")
		await animation.animation_finished
		await get_tree().create_timer(1.0).timeout
	
	transition_anim.play("fadeout")
	await transition_anim.animation_finished
	
	go_back_menu()
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

extends Control

func _ready() -> void:
	PlayerStats.reset_stats()

func _on_start_pressed() -> void:
	PlayerStats.curr_level = "start"
	SceneLoader.load_scene(Constants.SCENE_PATHS.house_1)

func _on_quit_pressed() -> void:
	get_tree().quit()

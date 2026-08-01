extends Control

func _on_start_pressed() -> void:
	PlayerStats.curr_level = "messy_house"
	SceneLoader.load_scene(Constants.SCENE_PATHS.messy_house)

func _on_quit_pressed() -> void:
	get_tree().quit()

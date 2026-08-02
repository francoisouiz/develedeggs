extends Control

func _on_start_pressed() -> void:
	PlayerStats.curr_level = "messy_house"
	SceneLoader.load_scene(Constants.SCENE_PATHS.house_2)

func _on_quit_pressed() -> void:
	get_tree().quit()

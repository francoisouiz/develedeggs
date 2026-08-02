extends Control

func _on_start_pressed() -> void:
	PlayerStats.curr_level = "province"
	SceneLoader.load_scene(Constants.SCENE_PATHS.province)

func _on_quit_pressed() -> void:
	get_tree().quit()

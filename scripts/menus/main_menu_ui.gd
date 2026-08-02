extends Control

func _on_start_pressed() -> void:
	PlayerStats.curr_level = "start"
	SceneLoader.load_scene(Constants.SCENE_PATHS.store_inside)

func _on_quit_pressed() -> void:
	get_tree().quit()

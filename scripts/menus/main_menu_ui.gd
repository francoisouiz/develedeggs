extends Control

func _on_start_pressed() -> void:
	PlayerStats.curr_level = "end"
	SceneLoader.load_scene(Constants.SCENE_PATHS.cemetery)

func _on_quit_pressed() -> void:
	get_tree().quit()

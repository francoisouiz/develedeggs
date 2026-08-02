extends Control

func _on_start_pressed() -> void:
	PlayerStats.curr_level = "store_outside"
	SceneLoader.load_scene(Constants.SCENE_PATHS.store_outside)

func _on_quit_pressed() -> void:
	get_tree().quit()

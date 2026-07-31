extends Control

func _on_start_pressed() -> void:
	SceneLoader.load_scene(Constants.SCENE_PATHS.house_1)

func _on_quit_pressed() -> void:
	get_tree().quit()

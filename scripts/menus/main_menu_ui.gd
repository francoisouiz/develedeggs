extends Control

var scenes: Dictionary[String, String] = {
	"start": Constants.SCENE_PATHS.house_1,
	"store_outside": Constants.SCENE_PATHS.store_outside,
	"store_inside": Constants.SCENE_PATHS.store_inside,
	"messy_house": Constants.SCENE_PATHS.house_2,
	"province": Constants.SCENE_PATHS.province,
	"cemetery": Constants.SCENE_PATHS.cemetery
}

@export var curr_scene: String = "start"

func _ready() -> void:
	PlayerStats.reset_stats()

func _on_start_pressed() -> void:
	PlayerStats.curr_level = curr_scene
	SceneLoader.load_scene(scenes[curr_scene])

func _on_quit_pressed() -> void:
	get_tree().quit()

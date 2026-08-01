extends Node

var curr_level: String = ""
var scene_progress: int = 0
var can_move: bool = false
var in_photo: bool = false

func continue_scene() -> void:
	scene_progress += 1

extends Node

var curr_level: String = ""
var level_pointer: int = 0
var can_move: bool = false
var in_photo: bool = false

func increase_pointer() -> void:
	level_pointer += 1

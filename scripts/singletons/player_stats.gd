extends Node

var curr_level: String = ""
var scene_progress: int = 0
var can_move: bool = false
var has_cam: bool = false
var can_photo: bool = true
var in_photo: bool = false
var has_talked_house: bool = false
var calendar_interacted: bool = false
var bed_interacted: bool = false
var console_interacted: bool = false
var post_photo_played: bool = false
var has_food1: bool = false
var has_food2: bool = false
var has_clothes: bool = false
var can_watch: bool = false
var can_jacket: bool = false
var can_medicine: bool = false
var picked_up_watch: bool = false
var picked_up_medicine: bool = false
var picked_up_jacket: bool = false
var can_carrier: bool = false
var picked_up_carrier: bool = false

func continue_scene() -> void:
	scene_progress += 1

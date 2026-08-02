extends Node

var curr_level: String = ""
var scene_progress: int = 0
var can_move: bool = false

# House 1
var has_cam: bool = false
var has_talked_to_josh: bool = false
var can_photo: bool = true
var in_photo: bool = false
var has_talked_house: bool = false
var calendar_interacted: bool = false
var bed_interacted: bool = false
var console_interacted: bool = false
var post_photo_played: bool = false

# Store Outside
var found_key: bool = false
var has_key: bool = false

# Store Inside
var has_food1: bool = false
var has_food2: bool = false
var has_clothes: bool = false

# House 2
var can_watch: bool = false
var can_jacket: bool = false
var can_medicine: bool = false
var picked_up_watch: bool = false
var picked_up_medicine: bool = false
var picked_up_jacket: bool = false
var can_carrier: bool = false
var picked_up_carrier: bool = false

# Province
var has_placed_jacket: bool = false
var has_placed_puto: bool = false
var has_placed_bibingka: bool = false

func continue_scene() -> void:
	scene_progress += 1

func reset_stats() -> void:
	curr_level = ""
	scene_progress = 0
	can_move = false

	# House 1
	has_cam = false
	has_talked_to_josh = false
	can_photo = true
	in_photo = false
	has_talked_house = false
	calendar_interacted = false
	bed_interacted = false
	console_interacted = false
	post_photo_played = false

	# Store Outside
	found_key = false
	has_key = false

	# Store Inside
	has_food1 = false
	has_food2 = false
	has_clothes = false

	# House 2
	can_watch = false
	can_jacket = false
	can_medicine = false
	picked_up_watch = false
	picked_up_medicine = false
	picked_up_jacket = false
	can_carrier = false
	picked_up_carrier = false
	
	print("RESET!")

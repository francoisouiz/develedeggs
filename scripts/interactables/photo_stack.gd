extends Node2D

@onready var photo_3: Sprite2D = $Photo3
@onready var photo_2: Sprite2D = $Photo2
@onready var photo_1: Sprite2D = $Photo1

@onready var photos: Array[Sprite2D] = [photo_1, photo_2, photo_3]
var photo_count: int = 0

func _ready() -> void:
	for photo: Sprite2D in photos:
		photo.visible = false

func reveal_photo() -> void:
	photos[photo_count].visible = true
	photo_count += 1

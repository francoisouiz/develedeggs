extends StaticBody2D

@onready var past_sprite: Sprite2D = $PastSprite
@onready var new_sprite: Sprite2D = $NewSprite

var current_form: String = "new"

func switch_form(target_form: String = "") -> void:
	if target_form == "":
		if current_form == "new":
			target_form = "old"
		elif current_form == "old":
			target_form = "new"
	
	if target_form == "new":
		past_sprite.visible = false
		new_sprite.visible = true
	elif target_form == "old":
		past_sprite.visible = true
		new_sprite.visible = false

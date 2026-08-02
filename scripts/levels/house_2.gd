extends Node2D

@onready var cat: StaticBody2D = $Interactable/Cat

func _ready() -> void:
	cat.get_node("AnimatedSprite2D").play("seated")

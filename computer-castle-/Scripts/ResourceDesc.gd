extends Area2D

@export var hover_scale := 1.3
@export var description_text := ""

@onready var sprite = $Sprite2D
@onready var label = get_tree().get_first_node_in_group("Description")
var original_scale := Vector2.ONE

func _ready():
	original_scale = sprite.scale
	mouse_entered.connect(_on_enter)
	mouse_exited.connect(_on_exit)


func _on_enter():
	sprite.scale = original_scale * hover_scale
	if label:
		label.text = description_text.replace("\\n", "\n")


func _on_exit():
	sprite.scale = original_scale
	label.text = "Click on a resource to answer a question! Hover to read descriptions."

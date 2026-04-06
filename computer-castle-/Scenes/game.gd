extends Node2D

@export var question_scene: PackedScene
@onready var popup_layer = $PopupLayer

func show_question_popup() -> bool:
	if question_scene == null:
		return false

	var popup = question_scene.instantiate()
	popup_layer.add_child(popup)

	get_tree().paused = true
	var correct = await popup.answered
	get_tree().paused = false

	return correct

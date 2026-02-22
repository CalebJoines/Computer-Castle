extends Area2D
@onready var scenepath: String = "res://Scenes/resource_picker.tscn"

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.pressed:
			print("Box was clicked. Switching scenes...")
			get_tree().change_scene_to_file(scenepath)

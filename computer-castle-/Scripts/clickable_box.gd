extends Area2D

@export var scene_path: String

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.pressed:
			print("Box was clicked. Switching scenes...")
			get_tree().change_scene_to_file(scene_path)

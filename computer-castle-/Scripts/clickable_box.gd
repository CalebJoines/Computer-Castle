extends Area2D

@export var scene_path: String
@export var bank: String

func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.pressed:
			print("Box was clicked. Switching scenes...")
			QuestionManager.set_bank(bank)
			ResourceManager.spend_energy(1)
			get_tree().change_scene_to_file(scene_path)

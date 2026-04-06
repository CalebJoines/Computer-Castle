extends AnimatedSprite2D

func _on_area_2d_submit_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.pressed:
			var scenepath = LevelManager.get_current_level()
			get_tree().change_scene_to_file(scenepath)
	

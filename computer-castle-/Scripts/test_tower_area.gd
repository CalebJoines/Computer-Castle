extends Area2D

var dragging := true

func _process(delta):
	if dragging:
		global_position = get_global_mouse_position()

func try_place():
	for slot in get_tree().get_nodes_in_group("slots"):
		if slot.can_place_tower() and slot.global_position.distance_to(global_position) < 32:
			slot.place_tower(self)
			dragging = false
			modulate = Color(1,1,1,1)
			return
	
	queue_free()

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if not event.pressed:
			try_place()
	

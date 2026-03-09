extends Area2D

@export var projectile_scene: PackedScene
@export var damage: int = 1
@export var fire_rate: float = 1.0

var enemies_in_range: Array[Node] = []
var can_shoot = true

var dragging := true

func _process(delta):
	if dragging:
		global_position = get_global_mouse_position()
	else:
		if can_shoot and enemies_in_range.size() > 0:
			var target = _get_first_valid_target()
			if target:
				shoot(target)

func try_place():
	print("trying to place")
	for slot in get_tree().get_nodes_in_group("slots"):
		if slot.can_place_tower() and slot.global_position.distance_to(global_position) < 32:
			print("placed")
			slot.place_tower(self)
			dragging = false
			modulate = Color(1,1,1,1)
			return
	
	queue_free()

func _input(event):
	if dragging and event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if not event.pressed:
			try_place()
		
func _get_first_valid_target():
	for enemy in enemies_in_range:
		if is_instance_valid(enemy):
			return enemy
	return null

func shoot(target):
	can_shoot = false
	
	if projectile_scene:
		print("firing projectile")
		var projectile = projectile_scene.instantiate()
		projectile.global_position = global_position
		projectile.target = target
		projectile.damage = damage
		get_tree().current_scene.add_child(projectile)
	
	await get_tree().create_timer(fire_rate).timeout
	can_shoot = true


func _on_area_entered(body: Area2D) -> void:
	if body.is_in_group("enemies"):
		enemies_in_range.append(body)

func _on_area_exited(body: Area2D) -> void:
	if body in enemies_in_range:
		enemies_in_range.erase(body)

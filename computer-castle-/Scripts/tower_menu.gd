		
extends Control

@export var base_tower_scene: PackedScene
@export var available_towers: Array[TowerData]

func spawn_tower(tower_data: TowerData) -> void:
	if base_tower_scene == null or tower_data == null:
		return

	var tower_instance = base_tower_scene.instantiate()
	tower_instance.tower_data = tower_data
	tower_instance.z_index = 100
	tower_instance.scale = Vector2(2, 2)
	tower_instance.modulate = Color(1, 1, 1, .7)
	
	get_tree().current_scene.add_child(tower_instance)


func _on_tesla_tower_buton_pressed() -> void:
	if available_towers.size() > 1:
		spawn_tower(available_towers[1])

func _on_cannon_tower_buton_pressed() -> void:
	if available_towers.size() > 0:
		spawn_tower(available_towers[0])

func _on_sniper_tower_buton_pressed() -> void:
	if available_towers.size() > 2:
		spawn_tower(available_towers[2])

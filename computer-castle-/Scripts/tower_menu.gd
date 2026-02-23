extends Control
#tower menu
@export var tower_scene: PackedScene 


func _on_tower_buton_pressed() -> void:
	if tower_scene:
		var tower_instance = tower_scene.instantiate()
		tower_instance.z_index = 100   
		tower_instance.modulate = Color(1,1,1,0.5)  # semi-transparent preview
		get_tree().current_scene.add_child(tower_instance)

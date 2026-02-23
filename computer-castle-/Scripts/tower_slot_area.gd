extends Area2D

var is_occupied = false
var current_tower = null

func can_place_tower() -> bool:
	return not is_occupied

func place_tower(tower):
	if can_place_tower():
		current_tower = tower
		tower.position = position  
		is_occupied = true

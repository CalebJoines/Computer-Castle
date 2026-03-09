extends Area2D
class_name Enemy

@export var max_hp: int = 10
@export var move_speed: float = 35.0
@export var damage_to_base: int = 1

var path_follow
var hp: int

func _ready():
	add_to_group("enemies")
	path_follow = get_parent()
	hp = max_hp
	
func _process(delta: float) -> void:
	path_follow.progress += move_speed * delta

func take_damage(amount: int):
	hp -= amount
	if hp <= 0:
		die()

func die():
	if path_follow:
		path_follow.queue_free()
	else:
		queue_free()

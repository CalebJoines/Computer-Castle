
extends Area2D
class_name TowerProjectile

@export var speed: float = 200.0
var damage: int = 1
var target: Node2D = null
var direction: Vector2 = Vector2.ZERO

func _ready() -> void:
	
	print("projectile ready, target = ", target)
	$Sprite2D.modulate = Color(1, 0, 0)

	area_entered.connect(_on_area_entered)

	if is_instance_valid(target):
		_update_direction()
	else:
		queue_free()

func _process(delta: float) -> void:
	if is_instance_valid(target):
		_update_direction()
	else:
		queue_free()
		return

	global_position += direction * speed * delta

func _update_direction() -> void:
	direction = (target.global_position - global_position).normalized()

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemies"):
		print("enemy hit")
		if area.has_method("take_damage"):
			area.take_damage(damage)
			print("enemy took damage")
		queue_free()

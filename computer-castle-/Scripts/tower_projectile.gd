extends Area2D

@export var speed: float = 200.0
@export var damage: int = 1

var target: Node2D = null
var direction: Vector2 = Vector2.ZERO

func _ready():
	print("projectile ready, target = ", target)
	$Sprite2D.modulate = Color(1, 0, 0)
	area_entered.connect(_on_area_entered)

	if is_instance_valid(target):
		direction = (target.global_position - global_position).normalized()
	else:
		queue_free()

func _process(delta):
	if is_instance_valid(target):
		direction = (target.global_position - global_position).normalized()
	else:
		queue_free()
	global_position += direction * speed * delta

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemies"):
		if area.has_method("take_damage"):
			area.take_damage(damage)
		queue_free()

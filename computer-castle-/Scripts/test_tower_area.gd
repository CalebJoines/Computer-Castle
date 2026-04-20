
extends Area2D
class_name BaseTower

@export var tower_data: TowerData

@onready var range_shape: CollisionShape2D = $TowerRange
@onready var sprite: Sprite2D = $Sprite2D

var enemies_in_range: Array[Area2D] = []
var can_shoot := false
var dragging := true

var sounds = {}

func _ready() -> void:
	_apply_tower_data()
	self.sounds = {
		"shoot": load(tower_data.shoot_audio)
	}

func _process(_delta: float) -> void:
	if dragging:
		global_position = get_global_mouse_position()
		return

	if can_shoot and enemies_in_range.size() > 0:
		var target := _get_target()
		if target:
			attack(target)

func _apply_tower_data() -> void:
	if tower_data == null:
		return

	if sprite and tower_data.tower_texture:
		sprite.texture = tower_data.tower_texture

	if range_shape and range_shape.shape is CircleShape2D:
		range_shape.shape = range_shape.shape.duplicate()
		range_shape.shape.radius = tower_data.range_radius

func _input(event: InputEvent) -> void:
	if dragging and event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
		try_place()

func try_place() -> void:
	var closest_slot = null
	var closest_distance = 32.0

	for slot in get_tree().get_nodes_in_group("slots"):
		var dist = slot.global_position.distance_to(global_position)
		if slot.can_place_tower(self) and dist < closest_distance:
			closest_slot = slot
			closest_distance = dist

	if closest_slot:
		var success = closest_slot.place_tower(self)
		if success:
			dragging = false
			global_position = closest_slot.global_position
			can_shoot = true
			modulate = Color(1, 1, 1, 1)
		else:
			queue_free()
	else:
		queue_free()

func _get_target() -> Area2D:
	enemies_in_range = enemies_in_range.filter(func(enemy): return is_instance_valid(enemy))

	if enemies_in_range.is_empty():
		return null
		print("Enemy is null")

	match tower_data.targeting_mode:
		"closest":
			var best = enemies_in_range[0]
			var best_dist = global_position.distance_to(best.global_position)
			for enemy in enemies_in_range:
				var dist = global_position.distance_to(enemy.global_position)
				if dist < best_dist:
					best = enemy
					best_dist = dist
			return best

		_:
			return enemies_in_range[0]

func attack(target: Area2D) -> void:
	can_shoot = false

	match tower_data.attack_type:
		"projectile":
			_fire_projectiles(target)
		"aoe":
			_fire_aoe(target)

	playsound("shoot")
	
	await get_tree().create_timer(tower_data.attack_rate).timeout
	can_shoot = true

func _fire_projectiles(target: Area2D) -> void:
	if tower_data.projectile_scene == null:
		return

	var count = max(tower_data.projectile_count, 1)

	for i in count:
		var projectile = tower_data.projectile_scene.instantiate()
		projectile.global_position = global_position
		projectile.target = target
		projectile.damage = tower_data.damage

		get_tree().current_scene.add_child(projectile)

func _hit_target_immediately(target: Area2D) -> void:
	if is_instance_valid(target) and target.has_method("take_damage"):
		target.take_damage(tower_data.damage)

func _fire_aoe(_target: Area2D) -> void:
	for enemy in enemies_in_range:
		if is_instance_valid(enemy) and enemy.has_method("take_damage"):
			enemy.take_damage(tower_data.damage)
			
		if tower_data.projectile_scene:
			var aoe = tower_data.projectile_scene.instantiate()
			aoe.global_position = global_position
			get_tree().current_scene.add_child(aoe)
			
		
	print("all enemies have been damaged")

func _on_area_entered(body: Area2D) -> void:
	if body.is_in_group("enemies") and body not in enemies_in_range:
		enemies_in_range.append(body)

func _on_area_exited(body: Area2D) -> void:
	if body in enemies_in_range:
		enemies_in_range.erase(body)
		
func playsound(name):
	var player = AudioStreamPlayer.new()
	player.stream = sounds[name]
	player.volume_db = -10 
	add_child(player)
	player.play()
	player.finished.connect(player.queue_free)

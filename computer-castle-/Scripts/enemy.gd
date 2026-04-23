extends Area2D
class_name Enemy

@export var max_hp: int = 10
@export var move_speed: float = 50
@export var damage_to_base: int = 1
@export var diesound = AudioStream
@export var tower_hit_affect: PackedScene

@onready var animated_sprite: AnimatedSprite2D = find_child("AnimatedSprite2D", true, false) as AnimatedSprite2D
@onready var death: AnimatedSprite2D = find_child("death", true, false) as AnimatedSprite2D
@onready var collision_shape: CollisionShape2D = find_child("CollisionShape2D", true, false) as CollisionShape2D

var path_follow
var hp: int
var is_dying := false

var rng = RandomNumberGenerator.new()

func _ready():
	if death != null:
		death.visible = false

	rng.randomize()
	add_to_group("enemies")
	path_follow = get_parent()
	hp = max_hp

func _process(delta: float) -> void:
	if is_dying:
		return

	path_follow.progress += move_speed * delta
	if path_follow.progress_ratio >= 1.0:
		var dice_roll = rng.randi_range(1,10)
		if dice_roll != 1:
			ResourceManager.take_damage(1)

		if tower_hit_affect:
			var effect = tower_hit_affect.instantiate()
			get_tree().current_scene.add_child(effect)
			effect.global_position = global_position

		queue_free()

func take_damage(amount: int):
	if is_dying:
		return

	hp -= amount
	if hp <= 0:
		die()

func die():
	if is_dying:
		return
	is_dying = true

	monitoring = false
	monitorable = false

	if collision_shape != null:
		collision_shape.disabled = true

	var player = AudioStreamPlayer.new()
	player.stream = diesound
	get_tree().current_scene.add_child(player)
	player.play()

	if animated_sprite != null:
		animated_sprite.visible = false

	if death != null:
		death.visible = true
		death.play("death")
		await death.animation_finished

	await player.finished
	player.queue_free()

	if path_follow:
		path_follow.queue_free()
	else:
		queue_free()

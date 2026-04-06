extends Area2D
class_name Enemy

@export var max_hp: int = 10
@export var move_speed: float = 50
@export var damage_to_base: int = 1
@export var diesound = AudioStream
var path_follow
var hp: int

var rng = RandomNumberGenerator.new()

func _ready():
	
	rng.randomize()
	add_to_group("enemies")
	path_follow = get_parent()
	hp = max_hp

	
func _process(delta: float) -> void:
	path_follow.progress += move_speed * delta
	if path_follow.progress_ratio >= 1.0:
		var dice_roll = rng.randi_range(1,10)
		if dice_roll != 1:
			ResourceManager.take_damage(1)
			queue_free()

func take_damage(amount: int):
	hp -= amount
	if hp <= 0:
		die()

func die():
	var player = AudioStreamPlayer.new()
	player.stream = diesound
	get_tree().current_scene.add_child(player)
	player.play()
	await player.finished
	player.queue_free()
	
	if path_follow:
		path_follow.queue_free()
	else:
		queue_free()

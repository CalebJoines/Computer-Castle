extends Node2D
class_name EnemySpawner

@export var level_data: LevelData
@export var path: Path2D
var inTutorial = ResourceManager.in_Tutorial()
var current_wave := 0
var wave_in_progress := false

func _ready():
	start_level()

func start_level() -> void:
	print("Starting Level")
	current_wave = 0
	await _run_all_waves()

func _run_all_waves() -> void:
	for wave in level_data.waves:
		await get_tree().create_timer(wave.delay_before_wave).timeout
		await _run_wave(wave)

		# Optional: wait until all enemies from this wave are dead
		await _wait_until_wave_cleared()
	if inTutorial == true:
		get_tree().change_scene_to_file("res://Scenes/Tutorial/tutorialcomplete.tscn")
	else:
		get_tree().change_scene_to_file("res://Scenes/win_scene.tscn")

func _run_wave(wave: WaveData) -> void:
	wave_in_progress = true

	for spawn_group in wave.spawns:
		for i in range(spawn_group.count):
			_spawn_enemy(spawn_group.enemy_scene)
			await get_tree().create_timer(spawn_group.spawn_interval).timeout

	wave_in_progress = false

func _spawn_enemy(enemy_scene: PackedScene) -> void:
	var enemy = enemy_scene.instantiate()

	# Example if using PathFollow2D
	var path_follow := PathFollow2D.new()
	path_follow.loop = false
	path.add_child(path_follow)
	path_follow.add_child(enemy)

func _wait_until_wave_cleared() -> void:
	while wave_in_progress or get_tree().get_nodes_in_group("enemies").size() > 0:
		await get_tree().process_frame

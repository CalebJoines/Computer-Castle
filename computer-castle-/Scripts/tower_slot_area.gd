
extends Area2D

var is_occupied = false
var current_tower = null
var sounds = {
	"cantplace": preload("res://Audio/Sound_effects/Map_SFX/Not_Enough_Resources.mp3"),
	"place": preload("res://Audio/Sound_effects/Tower_SFX/Build_Tower.mp3"),
}

func _ready():
	add_to_group("slots")

func playsound(name):
	var player = AudioStreamPlayer.new()
	player.stream = sounds[name]
	add_child(player)
	player.play()
	player.finished.connect(player.queue_free)

func can_place_tower(tower = null) -> bool:
	if is_occupied:
		return false
	if tower == null or tower.tower_data == null:
		return false
	return ResourceManager.get_volts() >= tower.tower_data.cost

func place_tower(tower) -> bool:
	if not can_place_tower(tower):
		playsound("cantplace")
		return false

	playsound("place")
	current_tower = tower
	tower.global_position = global_position
	is_occupied = true
	ResourceManager.spend_volts(tower.tower_data.cost)
	print("placed tower!")
	return true

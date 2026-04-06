
extends Area2D

var is_occupied = false
var current_tower = null
@onready var Baseplate= %plate
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
	for cost in tower.tower_data.cost:
		match cost[1]:
			"bandwidth":
				if ResourceManager.get_bandwidth() < cost[0]:
					return false
			"volts":
				if ResourceManager.get_volts() < cost[0]:
					return false
			"data":
				if ResourceManager.get_data() < cost[0]:
					return false
			"circuits":
				if ResourceManager.get_circuits() < cost[0]:
					return false
			"ai cores":
				if ResourceManager.get_ai_cores() < cost[0]:
					return false
	return true

func place_tower(tower) -> bool:
	if not can_place_tower(tower):
		playsound("cantplace")
		return false

	playsound("place")
	current_tower = tower
	tower.get_parent().remove_child(tower)
	add_child(tower)	
	tower.global_position = global_position
	tower.scale = Vector2(2, 2)
	is_occupied = true
	Baseplate.visible=true
	for cost in tower.tower_data.cost:
		match cost[1]:
			"bandwidth":
				ResourceManager.spend_bandwidth(cost[0])
			"volts":
				ResourceManager.spend_volts(cost[0])
			"data":
				ResourceManager.spend_data(cost[0])
			"circuits":
				ResourceManager.spend_circuits(cost[0])
			"ai cores":
				ResourceManager.spend_ai_cores(cost[0])
	print("placed tower!")
	return true

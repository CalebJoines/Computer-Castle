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

func can_place_tower() -> bool:
	return not is_occupied

func place_tower(tower):
	if not can_place_tower():
		return false
	if ResourceManager.get_volts() >= 1:
		playsound("place")
		current_tower = tower
		tower.global_position = global_position
		is_occupied = true
		ResourceManager.spend_volts(1)
		return true
	else:
		playsound("cantplace")
		return false

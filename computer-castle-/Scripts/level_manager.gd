extends Node
var levels = [
	"res://Scenes/game.tscn", 
	"res://Scenes/gamelevel2.tscn",
	"res://Scenes/gamelevel3.tscn"
	]
@onready var current_level_index = 0

#Call this to load the current tower defense level
func get_current_level() -> String:
	if current_level_index >= 0 and current_level_index < levels.size():
		return levels[current_level_index]
	return ""
	
func get_current_level_index():
	return current_level_index

#Call this when level is beaten
func set_next_level() -> void:
	if current_level_index < levels.size() -1 :
		current_level_index += 1
	else:
		print("Already at last level")

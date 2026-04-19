extends Node2D
@onready var blocker= %Blocker
@onready var text = %Text
func _ready() -> void:
	await get_tree().create_timer(5).timeout
	text.visible=false
	blocker.visible= false
	

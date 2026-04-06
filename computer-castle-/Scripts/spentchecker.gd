extends Node2D
@onready var button =%SubmitButton

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if ResourceManager.get_energy() == 0:
		button.visible=true
	else:
		button.visible=false

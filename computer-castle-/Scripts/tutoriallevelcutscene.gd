extends Node2D
@onready var continuebutton= %"Continue"
@onready var blocker= %"Blocker"
var sounds = {
	"click": preload("res://Audio/Sound_effects/Question_SFX/Click.mp3"),
	}

func playsound(name):
	var player = AudioStreamPlayer.new()
	player.stream = sounds[name]
	add_child(player)
	player.play()
	player.finished.connect(player.queue_free)

func _ready() -> void:
	ResourceManager.reset_resources()
	ResourceManager.add_ai_cores(5)
	ResourceManager.add_bandwidth(5)
	ResourceManager.add_circuits(5)
	ResourceManager.add_data(5)
	ResourceManager.add_volts(5)
	await get_tree().create_timer(10).timeout
	blocker.mouse_filter = Control.MouseFilter.MOUSE_FILTER_PASS
	continuebutton.visible=true


func _on_area_2d_submit_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			playsound("click")	
			continuebutton.play("Clicked")
			await get_tree().create_timer(.7).timeout
			get_tree().change_scene_to_file("res://Scenes/Tutorial/tutoriallevel.tscn")

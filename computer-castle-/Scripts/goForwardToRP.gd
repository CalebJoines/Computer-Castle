extends AnimatedSprite2D

var sounds = {"click": preload("res://Audio/Sound_effects/Question_SFX/Click.mp3"),
				"win": preload("res://Audio/Sound_effects/Map_SFX/Level_passed.mp3"),
}
@onready var scenepath: String = "res://Scenes/resource_picker.tscn"

func _ready() -> void:
	playsound("win")
		

func playsound(name):
	var player = AudioStreamPlayer.new()
	player.stream = sounds[name]
	add_child(player)
	player.play()
	player.finished.connect(player.queue_free)

func on_button_press(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			print("clicked")
			playsound("click")
			await get_tree().create_timer(0.5).timeout
			var level_index = LevelManager.get_current_level_index()
			if level_index >=2:
				scenepath = "res://Scenes/game_win.tscn"
			else:
				LevelManager.set_next_level()
				
			get_tree().change_scene_to_file(scenepath)

extends AnimatedSprite2D
@onready var skippath: String = "res://Scenes/resource_picker.tscn"

@onready var start= %StartButton
@onready var skip = %SkipButton
var sound= {
	"click": preload("res://Audio/Sound_effects/Question_SFX/CorrectDing.mp3")}

func playsound(name):
	var player = AudioStreamPlayer.new()
	player.stream = sound[name]
	add_child(player)
	player.play()
	player.finished.connect(player.queue_free)


func _on_area_2d_skip_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:		
			playsound("click")
			skip.play("Clicked")
			ResourceManager.exit_tutorial()
			await get_tree().create_timer(1).timeout
			get_tree().change_scene_to_file(skippath)		
	
	

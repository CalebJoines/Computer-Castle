extends AnimatedSprite2D
var current_text = 0
var next_text = 1
@onready var texts = [%"1", %"2", %"3", %"4", %"5"]
@onready var button = %"Continue"
var sounds = {
	"click": preload("res://Audio/Sound_effects/Question_SFX/Click.mp3")}

func _ready():
	button.play("Unclicked")
	await get_tree().create_timer(5).timeout
	button.visible=true
	

func playsound(name):
	var player = AudioStreamPlayer.new()
	player.stream = sounds[name]
	add_child(player)
	player.play()
	player.finished.connect(player.queue_free)


func _on_area_2d_submit_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			playsound("click")
			button.play("Clicked")
			texts[current_text].visible = false
			await get_tree().create_timer(0.6).timeout
			button.visible=false
			set_next_text()
			texts[current_text].visible = true
			if current_text < 3:
				await get_tree().create_timer(5).timeout
				button.visible=true
				button.play("Unclicked")
			elif current_text == 3:
				ResourceManager.add_ai_cores(5)
				ResourceManager.add_bandwidth(5)
				ResourceManager.add_circuits(5)
				ResourceManager.add_data(5)
				ResourceManager.add_volts(5)
				await %"Slot1".tower_placed
				button.visible=true
				button.play("Unclicked")
			else:
				await get_tree().create_timer(7).timeout
				get_tree().change_scene_to_file("res://Scenes/Tutorial/question_tutorial.tscn")
							
			
func set_next_text():
	if next_text < 4:
		current_text+=1
		next_text+=1
		print(next_text)
	elif next_text == 4:
		current_text=4
		next_text+=1
	

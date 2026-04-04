extends Control
#buttons
@onready var answerA: AnimatedSprite2D = %"AnswerButton A"
@onready var answerB: AnimatedSprite2D = %"AnswerButton B"
@onready var answerC: AnimatedSprite2D = %"AnswerButton C"
@onready var answerD: AnimatedSprite2D = %"AnswerButton D"
@onready var subbutton: AnimatedSprite2D = %"SubmitButton"
@onready var continue_button: AnimatedSprite2D =%ContinueButton
#
@onready var question_label: Label = %QuestionText
@onready var explanation_label: Label = %ExplanationLabel
@onready var answer_a_text: Label = %ChoiceA
@onready var answer_b_text: Label = %ChoiceB
@onready var answer_c_text: Label = %ChoiceC
@onready var answer_d_text: Label = %ChoiceD

#button checks
@onready var achecked : bool = false
@onready var bchecked : bool = false
@onready var cchecked : bool = false
@onready var dchecked : bool = false

@onready var scenepath: String = "res://Scenes/resource_picker.tscn"
var current_question = {}
var selected_answer = ""
var sounds = {
	"click": preload("res://Audio/Sound_effects/Question_SFX/Click.mp3"),
	"correct": preload("res://Audio/Sound_effects/Question_SFX/CorrectDing.mp3"),
	"incorrect":preload("res://Audio/Sound_effects/Question_SFX/IncorrectDing.mp3")
}

func _ready():
	subbutton.visible = false
	explanation_label.visible = false
	continue_button.visible = false
	load_question()

func playsound(name):
	var player = AudioStreamPlayer.new()
	player.stream = sounds[name]
	add_child(player)
	player.play()
	player.finished.connect(player.queue_free)

func load_question():
	current_question = QuestionManager.get_question()
	if current_question.is_empty():
		question_label.text = "Error, question bank empty"
		answerA.visible = false
		answerB.visible = false
		answerC.visible = false
		answerD.visible = false
		subbutton.visible = false
		return
	question_label.text = current_question["question"]
	answer_a_text.text = current_question["choices"][0]
	answer_b_text.text = current_question["choices"][1]
	answer_c_text.text = current_question["choices"][2]
	answer_d_text.text = current_question["choices"][3]
	
func get_selected_answer() -> int:
	if achecked:
		return 0
	if bchecked:
		return 1
	if cchecked:
		return 2
	if dchecked:
		return 3
	return -1

func reset_selection():
	achecked = false
	bchecked = false
	cchecked = false
	dchecked = false
	answerA.play("Unclicked")
	answerB.play("Unclicked")
	answerC.play("Unclicked")
	answerD.play("Unclicked")
	subbutton.visible = false
	
func show_explanationI():
	playsound("incorrect")
	explanation_label.text = current_question["explanation"]
	question_label.add_theme_color_override("font_color",Color("red"))
	question_label.text = "Incorrect!"
	explanation_label.visible = true
	answerA.visible = false
	answerB.visible = false
	answerC.visible = false
	answerD.visible = false
	subbutton.visible = false
	await get_tree().create_timer(5.0).timeout
	continue_button.visible = true
	
func show_explanationC():
	playsound("correct")
	explanation_label.text = current_question["explanation"]
	question_label.add_theme_color_override("font_color",Color("dark green"))
	question_label.text = "Correct!"
	explanation_label.visible = true
	continue_button.visible = true
	answerA.visible = false
	answerB.visible = false
	answerC.visible = false
	answerD.visible = false
	subbutton.visible = false

'''
	"MediaLiteracy": "volts",
	"DigitalFootprint": "data",
	"DigitalThreats": "circuits",
	"Scams_and_links": "bandwidth",
	"Security": "ai_cores"
'''
	
func check_answer():
	selected_answer = get_selected_answer()
	var bank = QuestionManager.get_bank()
	if selected_answer == -1:   
		return
	if selected_answer == current_question["correct_index"]:
		print("Correct!")
		if (bank == "DigitalFootprint"):
			ResourceManager.add_data(10)
		if (bank == "DigitalThreats"):
			ResourceManager.add_circuits(10)
		if (bank == "MediaLiteracy"):
			ResourceManager.add_volts(10)
		if (bank == "Scams_and_links"):
			ResourceManager.add_bandwidth(10)
		if (bank == "Security"):
			ResourceManager.add_ai_cores(10)
			
		QuestionManager.remove_question(current_question)
		show_explanationC()
	else:
		if (bank == "DigitalFootprint"):
			ResourceManager.add_data(5)
		if (bank == "DigitalThreats"):
			ResourceManager.add_circuits(5)
		if (bank == "MediaLiteracy"):
			ResourceManager.add_volts(5)
		if (bank == "Scams_and_links"):
			ResourceManager.add_bandwidth(5)
		if (bank == "Security"):
			ResourceManager.add_ai_cores(5)
		print("Incorrect! Try Reading the Explanation")
		show_explanationI()

func _on_area_2d_a_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:	
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			playsound("click")
			if achecked == false :
				print("Selecting A")
				answerA.play("Clicked")
				answerB.play("Unclicked")
				answerC.play("Unclicked")
				answerD.play("Unclicked")
				achecked = true
				bchecked = false
				cchecked= false
				dchecked = false
				subbutton.visible = true
			else:
				print("Unselecting A")
				answerA.play("Unclicked")
				achecked = false
				subbutton.visible = false


func _on_area_2d_b_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			playsound("click")
			if bchecked == false :
				print("Selecting B")
				answerA.play("Unclicked")
				answerB.play("Clicked")
				answerC.play("Unclicked")
				answerD.play("Unclicked")
				achecked = false
				bchecked = true
				cchecked= false
				dchecked = false
				subbutton.visible = true
			else:
				print("Unselecting B")
				answerB.play("Unclicked")
				bchecked = false
				subbutton.visible = false
			
func _on_area_2d_c_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			playsound("click")
			if cchecked == false :
				print("Selecting C")
				answerA.play("Unclicked")
				answerB.play("Unclicked")
				answerC.play("Clicked")
				answerD.play("Unclicked")
				achecked = false
				bchecked = false
				cchecked= true
				dchecked = false
				subbutton.visible = true
			else: 
				print("Unselecting C")
				answerC.play("Unclicked")
				cchecked = false
				subbutton.visible = false

func _on_area_2d_d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			playsound("click")
			if dchecked == false :
				print("Selecting D")
				answerA.play("Unclicked")
				answerB.play("Unclicked")
				answerC.play("Unclicked")
				answerD.play("Clicked")
				achecked = false
				bchecked = false
				cchecked= false
				dchecked = true
				subbutton.visible = true
			else: 
				print("Unselecting D")
				answerD.play("Unclicked")
				dchecked = false
				subbutton.visible = false
	
func _on_area_2d_submit_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			playsound("click")
			if achecked == true:
				print("Answered A")
			if bchecked == true:
				print("Answered B")
			if cchecked == true:
				print("Answered C")
			if dchecked == true:
				print("Answered D")
			check_answer()

func _on_area_2d_continue_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			playsound("click")
			await get_tree().create_timer(0.7).timeout
			get_tree().change_scene_to_file(scenepath)

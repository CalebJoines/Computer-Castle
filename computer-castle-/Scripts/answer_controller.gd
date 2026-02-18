extends Control

@onready var answerA: AnimatedSprite2D = %"AnswerButton A"
@onready var answerB: AnimatedSprite2D = %"AnswerButton B"
@onready var answerC: AnimatedSprite2D = %"AnswerButton C"
@onready var answerD: AnimatedSprite2D = %"AnswerButton D"
@onready var subbutton: AnimatedSprite2D = %"SubmitButton"
@onready var scenepath: String = "res://Scenes/resource_picker.tscn"
@onready var achecked : bool = false
@onready var bchecked : bool = false
@onready var cchecked : bool = false
@onready var dchecked : bool = false

func _ready():
	subbutton.visible = false
	

func _on_area_2d_a_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:	
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
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
			if achecked == true:
				print("Answered A")
			if bchecked == true:
				print("Answered B")
			if cchecked == true:
				print("Answered C")
			if dchecked == true:
				print("Answered D")
			print("Submitting. Switching scenes...")	
			achecked = false
			bchecked = false
			cchecked = false
			dchecked = false
			get_tree().change_scene_to_file(scenepath)

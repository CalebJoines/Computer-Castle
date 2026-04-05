extends Timer

@onready var label=%Time_left
@onready var time=%Question_Timer

func _process(_delta: float) -> void:
	update_label_text()
	
func update_label_text():
	label.text = "%.2f" %time.time_left

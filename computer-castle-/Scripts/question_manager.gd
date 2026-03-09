extends Node2D

var question_banks = {}
var current_bank = ""
var current_questions = []

var bank_rewards = {
	"MediaLiteracy": "volts",
	"CyberSecurity": "data",
	"Programming": "circuits",
	"Networking": "bandwidth",
	"AI": "ai_cores"
}


func _ready():
	load_all_banks()	
	ResourceManager.spend_energy(1)
	print(question_banks.keys()) #for debugging
	set_bank("MediaLiteracy")

func load_all_banks():
	var dir = DirAccess.open("res://Questions")
	if dir == null:
		print("Questions folder not found!")
		return
	dir.list_dir_begin()
	var file_name = dir.get_next()
	while file_name != "":
		if file_name.ends_with(".json"):
			var path = "res://Questions/" + file_name
			var file = FileAccess.open(path, FileAccess.READ)
			if file:
				var text = file.get_as_text()
				var json = JSON.new()
				var error = json.parse(text)
				if error != OK:
					print("JSON ERROR in:", file_name)
					print("Line:", json.get_error_line())
					print("Message:", json.get_error_message())
				else:
					var data = json.data
					var bank_name = file_name.replace(".json","")
					if data.has("questions"):
						question_banks[bank_name] = data["questions"]
						print("Loaded bank:", bank_name)
					else:
						print("Missing 'questions' array in:", file_name)
				file.close()
		file_name = dir.get_next()
	dir.list_dir_end()


func set_bank(bank_name):
	if bank_name in question_banks:
		current_bank = bank_name
		current_questions = question_banks[bank_name].duplicate(true)
		print("Bank selected:", bank_name)


func get_question():
	if current_questions.size() == 0:
		return {}
	var index = randi() % current_questions.size()
	return current_questions[index]


func remove_question(question):
	current_questions.erase(question)

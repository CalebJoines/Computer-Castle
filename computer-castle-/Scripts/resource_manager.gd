extends Node
@onready var scenepath= "res://Scenes/loss_screen.tscn"

# RESOURCE VALUES
var volts : int = 90
var data : int = 90
var circuits : int = 90
var bandwidth : int = 90
var ai_cores : int = 90
var energy : int = 5
var health: int = 23:
	set(value):
		health = clamp(value, 0, max_health) #ensures health doesn't go outside normal rangee
		emit_signal("health_changed", health)
var max_health: int = 23
var in_tutorial = true

signal health_changed(new_health)
# ADD RESOURCES
func add_volts(amount:int):
	volts += amount
	print("Volts:", volts)

func add_data(amount:int):
	data += amount
	print("Data:", data)

func add_circuits(amount:int):
	circuits += amount
	print("Circuits:", circuits)


func add_bandwidth(amount:int):
	bandwidth += amount
	print("Bandwidth:", bandwidth)


func add_energy(amount:int):
	energy += amount
	print("Energy:", energy)

func add_ai_cores(amount:int):
	ai_cores += amount
	print("AI Cores:", ai_cores)
	

# SPEND / REMOVE RESOURCES
func spend_volts(amount:int) -> bool:
	if volts >= amount:
		volts -= amount
		print("Volts remaining:", volts)
		return true
	else:
		print("Not enough volts")
		return false


func spend_data(amount:int) -> bool:
	if data >= amount:
		data -= amount
		print("Data remaining:", data)
		return true
	else:
		print("Not enough data")
		return false


func spend_circuits(amount:int) -> bool:
	if circuits >= amount:
		circuits -= amount
		print("Circuits remaining:", circuits)
		return true
	else:
		print("Not enough circuits")
		return false


func spend_bandwidth(amount:int) -> bool:
	if bandwidth >= amount:
		bandwidth -= amount
		print("Bandwidth remaining:", bandwidth)
		return true
	else:
		print("Not enough bandwidth")
		return false


func spend_energy(amount:int) -> bool:
	if energy >= amount:
		energy -= amount
		print("Energy remaining:", energy)
		return true
	else:
		print("Not enough energy")
		return false
		
func spend_ai_cores(amount:int) -> bool:
	if ai_cores >= amount:
		ai_cores -= amount
		return true
	return false
	
	
	# GETTERS
func get_volts() -> int:
	return volts


func get_data() -> int:
	return data


func get_circuits() -> int:
	return circuits


func get_bandwidth() -> int:
	return bandwidth


func get_ai_cores() -> int:
	return ai_cores


func get_energy() -> int:
	return energy
	
func reset_resources():
	ai_cores=0
	volts=0
	circuits=0
	bandwidth=0
	data=0
	health=max_health
	energy = ((LevelManager.get_current_level_index())*5)+10
	
#healthbar stuff
func take_damage(damage:int):
	if health > 0:
		health = health - damage
	else:
		get_tree().change_scene_to_file(scenepath)

func reset_health():
	health = max_health
	
func get_health():
	return health
	
func exit_tutorial():
	in_tutorial = false
	
func in_Tutorial():
	return in_tutorial

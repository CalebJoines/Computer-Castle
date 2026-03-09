extends Control

@onready var energy_label = $Panel/HBoxContainer/energy/EnergyValue
@onready var volts_label = $Panel/HBoxContainer/Volts/VoltsValue
@onready var circuits_label = $Panel/HBoxContainer/Circuits/CircuitsValue
@onready var bandwidth_label = $Panel/HBoxContainer/Bandwidth/BandwidthValue
@onready var data_label = $Panel/HBoxContainer/Data/DataValue
@onready var ai_label = $Panel/HBoxContainer/Cores/AICoresValue


func _process(_delta):
	update_resource_display()


func update_resource_display():
	energy_label.text = "%02d" % ResourceManager.get_energy()
	volts_label.text = "%02d" % ResourceManager.get_volts()
	data_label.text = "%02d" % ResourceManager.get_data()
	circuits_label.text = "%02d" % ResourceManager.get_circuits()
	bandwidth_label.text = "%02d" % ResourceManager.get_bandwidth()
	ai_label.text = "%02d" % ResourceManager.get_ai_cores()

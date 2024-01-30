extends Node2D
class_name PlantInterface

@onready var level_component:BoundedNumber = $Plant/Level
@onready var plant_component:Plant = $Plant

func _ready():
	if not level_component:
		push_error("No level component (BoundedNumber) supplied to plant interface class")
	if not plant_component:
		push_error("No plant component (Plant) supplied to plant interface class")

func get_data():
	var data = null
	return data

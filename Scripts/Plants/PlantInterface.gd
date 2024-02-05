extends Node2D
class_name PlantInterface

enum LightType {
	Yellow,
	Red,
	Blue,
}

@onready var level_component:BoundedNumber = $Level
@onready var growth_component:PlantGrowthComponent = $GrowthHandler
@onready var health_component:HealthComponent = $HealthComponent


func _on_create():
	if not level_component:
		push_error("No level component (BoundedNumber) supplied to plant interface class")
	if not growth_component:
		push_error("No growth component")

func _on_light_tick(delta:float, light_type:LightType):
	growth_component.light_tick(delta, light_type)

func _process(delta):
	pass

func get_data():
	var data = null
	return data

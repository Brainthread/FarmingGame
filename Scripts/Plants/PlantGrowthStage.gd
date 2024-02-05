extends Resource
class_name PlantGrowthStage

@export var progress_threshold:float = 10
@export var light_type_modifiers:Array[float]

func get_light_modifier (index:int):
	if index < 0 or index >= light_type_modifiers.size() or not light_type_modifiers[index]:
		return 1
	else:
		return light_type_modifiers[index]

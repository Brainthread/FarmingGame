extends Node
class_name PlantGrowthComponent

var progress:float = 0
var final_level:bool = false

@onready var level_handler:BoundedNumber = $"../Level"
@export var growthStage:Array[PlantGrowthStage] 

func light_tick(delta:float, light_type:PlantInterface.LightType):
	var stage = growthStage[level_handler.get_number()]
	if not growthStage:
		push_error("There is no corresponding growth stage loaded into plant. Aborting growth.")
	progress += stage.get_light_modifier(light_type)*delta
	if progress >= stage.progress_threshold and not final_level:
		var level_up_successful = level_handler.number_up()
		if level_up_successful:
			progress -= stage.progress_threshold
		else: final_level = true


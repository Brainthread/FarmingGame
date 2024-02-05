extends Resource
class_name PlantInstanceDictionary

@export var _plants:Array[PackedScene]

func get_plant(id:int):
	if _plants[id]:
		return _plants[id]
	return null

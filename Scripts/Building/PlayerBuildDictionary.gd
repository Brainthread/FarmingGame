extends Node2D
class_name PlayerBuildDictionary

var built_objects:Dictionary

func build_object(position:Vector2i, item:ItemData):
	built_objects[position] = item

func get_object(position:Vector2i) -> ItemData:
	if built_objects.has(position):
		return built_objects.get(position)
	return null
	
func destroy_object(position:Vector2i):
	built_objects[position] = null

extends Node2D
class_name PlayerGrid

var built_objects:Dictionary

func build_object(position:Vector2i, object:PackedScene):
	built_objects[position] = object
	
func get_object(position:Vector2i) -> PackedScene:
	if built_objects.has(position):
		return built_objects.get(position)
	return null
	
func destroy_object(position:Vector2i):
	pass

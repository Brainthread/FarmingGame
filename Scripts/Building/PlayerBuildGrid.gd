extends Node2D
class_name PlayerBuildGrid

var built_objects:Dictionary

func build_object_instance(position:Vector2i, real_position:Vector2, scene:PackedScene):
	var scene_instance = scene.instantiate()
	self.add_child(scene_instance)
	scene_instance.position = real_position
	built_objects[position] = scene_instance
	
func get_object_instance(position:Vector2i) -> PackedScene:
	if built_objects.has(position):
		return built_objects.get(position)
	return null
	
func destroy_object_instance(position:Vector2i):
	built_objects[position] = null

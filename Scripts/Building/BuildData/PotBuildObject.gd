extends Resource
class_name BuildObject

enum BuildType {
	decor,
	furniture,
}

@export var wall_placeable:bool = false
@export var build_type:BuildType = BuildType.furniture
@export var scene:PackedScene

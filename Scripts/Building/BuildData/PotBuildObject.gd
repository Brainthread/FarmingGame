extends Resource
class_name PotBuildObject

enum BuildType {
	decor,
	furniture,
}

@export var wall_placeable:bool = false
@export var build_type:BuildType = BuildType.furniture
@export var scene:PackedScene

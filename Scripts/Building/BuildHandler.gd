extends Node2D
class_name BuildHandler

@onready var grid: TileMap = $"../LevelGrid"
@onready var player_build_dictionary:PlayerBuildDictionary = $"../PlayerBuildDictionary"
@onready var player_build_grid:PlayerBuildGrid = $"../PlayerBuildGrid"
@export var valid_placement_color:Color
@export var invalid_placement_color:Color

var held_item

func _ready():
	if not player_build_dictionary:
		push_error("No PlayerBuildDictionary supplied")
	if not player_build_grid:
		push_error("No PlayerBuildGrid supplied")

func _mouse_pos_to_grid_pos() -> Vector2i:
	var mouse_pos = get_global_mouse_position()
	mouse_pos = grid.local_to_map(mouse_pos)
	return mouse_pos

func _grid_pos_to_world_pos(grid_position:Vector2i) -> Vector2:
	return grid.map_to_local(grid_position)

func get_preview_position() -> Vector2:
	var grid_pos = _mouse_pos_to_grid_pos()
	var world_pos = _grid_pos_to_world_pos(grid_pos)
	return world_pos

func can_build_at_position(grid_position:Vector2i):
	var cell = grid.get_cell_tile_data(0, grid_position)
	var builtobject = player_build_dictionary.get_object(grid_position)
	if cell:
		if cell.get_custom_data("is_buildable") and not builtobject:
			return true
	return false

func build_at_position(grid_position:Vector2i, item:ItemData) -> bool:
	if(can_build_at_position(grid_position)):
		var realposition = _grid_pos_to_world_pos(grid_position)
		var build_object = item.build_object
		player_build_dictionary.build_object(grid_position, item)
		player_build_grid.build_object_instance(grid_position, realposition, build_object.scene)
		return true
	return false

func _destroy_at_position(grid_position:Vector2i):
	pass

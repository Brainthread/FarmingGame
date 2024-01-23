extends Node2D
class_name BuildHandler

@onready var grid: TileMap = $"../LevelGrid"
@onready var playergrid = $"../PlayerGrid"
@export var valid_placement_color:Color
@export var invalid_placement_color:Color

var held_item

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

func _can_build_at_position(grid_position:Vector2i):
	var cell = grid.get_cell_tile_data(0, grid_position)
	var builtobject = playergrid.get_object(grid_position)
	if cell:
		if cell.get_custom_data("is_buildable") and not builtobject:
			return true
	return false
	
func _can_plant_at_position(_grid_position:Vector2i):
	var buildcell = grid.get_cell_tile_data(1, _grid_position)
	if buildcell:
		return true
	return false

func _build_at_position(grid_position:Vector2i):
	pass

func _plant_at_position(grid_position:Vector2i):
	grid.set_cell(1, grid_position, 0, Vector2i(0,1))

func _destroy_at_position(grid_position:Vector2i):
	grid.set_cell(1, grid_position, -1, Vector2i(-1, -1))
	var buildcell = grid.get_cell_tile_data(1, grid_position)
	buildcell = null
	pass


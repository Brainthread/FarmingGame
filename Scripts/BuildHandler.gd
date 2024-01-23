extends Node2D
class_name BuildHandler

@onready var grid: TileMap = $"../LevelGrid"
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
	if cell:
		if cell.get_custom_data("is_buildable"):
			return true
	return false
	
func _can_plant_at_position(_grid_position:Vector2i):
	return false

func _input(_event):
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		pass

extends PlayerItemInteraction

var world_build_handler:BuildHandler
@onready var indicator_object:PackedScene = load("res://Scenes/Objects/itempreview.tscn")
var indicator_instance
@export var build_range:float = 128

func start_holding():
	if not indicator_instance:
		indicator_instance = indicator_object.instantiate()
		add_child(indicator_instance)
	indicator_instance.visible = true

func stop_holding():
	indicator_instance.visible = false

func holding_update():
	indicator_instance.global_position = world_build_handler.get_preview_position()
	var mouse_grid_position = world_build_handler._mouse_pos_to_grid_pos()
	var _can_place_item = false
	if item.item_data is Placeable:
		_can_place_item = world_build_handler._can_build_at_position(mouse_grid_position)
	if item.item_data is Seedbag:
		_can_place_item = world_build_handler._can_plant_at_position(mouse_grid_position)
	if global_position.distance_to(world_build_handler._grid_pos_to_world_pos(mouse_grid_position)) > build_range:
		_can_place_item = false
	indicator_instance.get_child(0).modulate = world_build_handler.valid_placement_color \
			if _can_place_item \
			else world_build_handler.invalid_placement_color

func use():
	var mouse_grid_position = world_build_handler._mouse_pos_to_grid_pos()
	var _can_place_item = false
	if item.item_data is Placeable:
		_can_place_item = world_build_handler._can_build_at_position(mouse_grid_position)
		if _can_place_item:
			world_build_handler._build_at_position(mouse_grid_position)
	if item.item_data is Seedbag:
		_can_place_item = world_build_handler._can_plant_at_position(mouse_grid_position)
		if _can_place_item:
			world_build_handler._build_at_position(mouse_grid_position)
		

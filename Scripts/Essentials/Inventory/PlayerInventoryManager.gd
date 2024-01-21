extends Node
class_name PlayerInventoryManager

signal toggle_inventory
signal set_inventory_and_hotbar_visibility
signal set_active_inventory_slot

@export var inventory:Inventory
@export var inventory_size:int = 10
@export var hotbar_size:int = 5

var active_inventory_index = -1
var active_inventory_slot:InventorySlot
var enabled = true

@onready var item_interaction_manager = $ItemInteractionManager

func set_inventory_availability(value:bool):
	enabled = value
	set_inventory_and_hotbar_visibility.emit(value)

func _unhandled_input(event):
	if Input.is_action_just_pressed("Inventory"):
		toggle_inventory.emit()
	if enabled:
		if Input.is_key_pressed(KEY_1):
			set_active_inventory_item(0)
		if Input.is_key_pressed(KEY_2):
			set_active_inventory_item(1)
		if Input.is_key_pressed(KEY_3):
			set_active_inventory_item(2)
		if Input.is_key_pressed(KEY_4):
			set_active_inventory_item(3)
		if Input.is_key_pressed(KEY_5):
			set_active_inventory_item(4)

func set_active_inventory_item(index:int):
	if active_inventory_index == index:
		active_inventory_index = -1
		active_inventory_slot = null
	else:
		active_inventory_index = index
		active_inventory_slot = inventory.get_slot(index)
		print(index)
		if active_inventory_slot.item_data:
			print(active_inventory_slot.item_data.name)
		else:
			active_inventory_slot = null
			print(null)
	set_active_inventory_slot.emit(active_inventory_index)

func _process(delta):
	if active_inventory_slot:
		item_interaction_manager.hold_item(active_inventory_slot)
		

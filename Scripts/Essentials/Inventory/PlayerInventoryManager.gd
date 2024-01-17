extends Node
class_name PlayerInventoryManager

signal toggle_inventory
signal set_inventory_and_hotbar_visibility
signal set_active_inventory_slot

@export var inventory:Inventory
@export var inventory_size:int = 10
@export var hotbar_size:int = 5

var active_inventory_index = 0
var active_inventory_slot:InventorySlot
var enabled = true

func set_inventory_availability(value:bool):
	enabled = value
	set_inventory_and_hotbar_visibility.emit(value)

func _unhandled_input(event):
	if Input.is_action_just_pressed("Inventory"):
		toggle_inventory.emit()

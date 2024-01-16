extends Node
class_name PlayerInventoryManager

signal toggle_inventory
signal toggle_inventory_and_hotbar
signal set_active_inventory_slot

@export var inventory:Inventory
@export var inventory_size:int = 10

var active_inventory_slot = -1

func _unhandled_input(event):
	if Input.is_action_just_pressed("Inventory"):
		toggle_inventory.emit()

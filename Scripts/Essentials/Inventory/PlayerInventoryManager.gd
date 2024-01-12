extends Node
class_name PlayerInventoryManager

signal toggle_inventory

@export var inventory:Inventory
@export var inventory_size:int = 10

@export var inventory_panel:InventoryPanel
var active_inventory_slot = -1

func _unhandled_input(event):
	if Input.is_action_just_pressed("Inventory"):
		toggle_inventory.emit()

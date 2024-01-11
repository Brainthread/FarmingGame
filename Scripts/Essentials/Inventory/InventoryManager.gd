extends Node
class_name InventoryManager

@export var inventory:Inventory
@export var inventory_size:int = 10

@export var inventory_panel:InventoryPanel
var active_inventory_slot = 0

func _process(delta):
	if not inventory_panel:
		push_error("No inventory UI assigned")
	inventory = Inventory.new()
	inventory.initialize_inventory(inventory_size)
	inventory_panel.set_inventory_data(inventory)


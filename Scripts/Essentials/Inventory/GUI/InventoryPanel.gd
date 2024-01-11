extends PanelContainer
class_name InventoryPanel

const SlotAsset = preload("res://Scenes/UI/InventorySlot.tscn")

@onready var item_grid: GridContainer = $MarginContainer/ItemGrid

func set_inventory_data(inventory:Inventory) -> void:
	populate_item_grid(inventory.items)

func populate_item_grid(slot_datas: Array[InventorySlot]) -> void:
	for child in item_grid.get_children():
		child.queue_free()
	
	for slot_data in slot_datas:
		var slot = SlotAsset.instantiate()
		item_grid.add_child(slot)
		
		if slot_data.item_data:
			slot.set_slot_data(slot_data)

extends PanelContainer
class_name InventoryPanel

const SlotAsset = preload("res://Scenes/UI/InventorySlot.tscn")

@onready var item_grid: GridContainer = $MarginContainer/ItemGrid

func initialize():
	item_grid = $MarginContainer/ItemGrid

func set_inventory_data(inventory:Inventory):
	inventory.inventory_update.connect(populate_item_grid)
	populate_item_grid(inventory)

#should only be used in initialization
func populate_item_grid(inventory:Inventory):
	var slot_datas = inventory.items	
	for child in item_grid.get_children():
		child.queue_free()
	
	for slot_data in slot_datas:
		var slot = SlotAsset.instantiate()
		slot.initialize()
		item_grid.add_child(slot)
		
		slot.slot_clicked.connect(inventory.on_slot_clicked)
		
		if slot_data and slot_data.item_data:
			slot.set_slot_data(slot_data)

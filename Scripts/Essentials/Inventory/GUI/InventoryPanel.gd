extends PanelContainer
class_name InventoryPanel

const SlotAsset = preload("res://Scenes/UI/InventorySlot.tscn")

@onready var item_grid: GridContainer = $MarginContainer/ItemGrid
var _slots: Array[InventoryGUISlot]

#initialization
func initialize():
	item_grid = $MarginContainer/ItemGrid

#sets the inventory. Should only be used for initialization
func set_inventory_data(inventory:Inventory):
	inventory.inventory_update.connect(populate_item_grid)
	inventory.inventory_update_cell.connect(set_inventory_cell)
	populate_item_grid(inventory)

#sets a cell of the slots to the assigned data
func set_inventory_cell(slot_data:InventorySlot, index:int):
	if _slots[index]:
		var slot = _slots[index] as InventoryGUISlot
		slot.set_slot_data(slot_data)

#sets the background icon of a slot
func set_slot_background_icon(index:int, icon:Texture2D):
	if _slots[index]:
		var slot = _slots[index] as InventoryGUISlot
		slot.set_slot_background(icon)

#should only be used in initialization
func populate_item_grid(inventory:Inventory):
	var slot_datas = inventory.items	
	for child in item_grid.get_children():
		child.queue_free()
	
	_slots.resize(slot_datas.size())
	var i = 0
	for slot_data in slot_datas:
		var slot = SlotAsset.instantiate()
		slot.initialize()
		item_grid.add_child(slot)
		slot.slot_clicked.connect(inventory.on_slot_clicked)
		if slot_data and slot_data.item_data:
			slot.set_slot_data(slot_data)
		_slots[i] = slot
		i += 1

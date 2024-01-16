extends PanelContainer
class_name HotbarPanel

const SlotAsset = preload("res://Scenes/UI/InventorySlot.tscn")

@onready var item_grid: HBoxContainer = $MarginContainer/HBoxContainer
var _slots: Array[InventoryGUISlot]
@export var count:int = 5

func initialize():
	item_grid = $MarginContainer/ItemGrid


func set_inventory_data(inventory:Inventory):
	inventory.inventory_update.connect(populate_item_grid)
	inventory.inventory_update_cell.connect(set_inventory_cell)
	populate_item_grid(inventory)


func set_inventory_cell(slot_data:InventorySlot, index:int):
	if index > count -1:
		return
	if _slots[index]:
		var slot = _slots[index] as InventoryGUISlot
		slot.set_slot_data(slot_data)


func set_slot_background_icon(index:int, icon:Texture2D):
	if index > count -1:
		return
	if _slots[index]:
		var slot = _slots[index] as InventoryGUISlot
		slot.set_slot_background(icon)




#should only be used in initialization
func populate_item_grid(inventory:Inventory):
	var slot_datas = inventory.items	
	for child in item_grid.get_children():
		child.queue_free()
	
	_slots.resize(count)
	var i = 0
	for slot_data in slot_datas.slice(0, count):
		var slot = SlotAsset.instantiate()
		slot.initialize()
		item_grid.add_child(slot)
		if slot_data and slot_data.item_data:
			slot.set_slot_data(slot_data)
		_slots[i] = slot
		i += 1

extends Resource
class_name Inventory

signal inventory_interact(inventory: Inventory, index:int, button:int)
signal inventory_update(inventory:Inventory)
signal inventory_update_cell(data:InventorySlot, index:int)

@export var items: Array[InventorySlot]
var _size:int
const _library_path = "res://Data/Items/ItemLibrary.tres"
var _library:ItemLibrary

func grab_slot(index:int) -> InventorySlot:
	var slot_data = InventorySlot.new()
	slot_data.item_data = items[index].item_data
	slot_data.stack_count = items[index].stack_count
	clear_slot(index)
	inventory_update_cell.emit(items[index], index)
	return slot_data

func get_slot(index:int) -> InventorySlot:
	return items[index]

func clear_slot (index:int):
	items[index].item_data = null
	items[index].stack_count = 0

func drop_slot(index:int, grabbed_slot:InventorySlot) -> InventorySlot:
	var slot_data = InventorySlot.new()
	slot_data.item_data = grabbed_slot.item_data
	slot_data.stack_count = grabbed_slot.stack_count
	var item = slot_data.item_data
	var stackSpace = stack_space_for_item(index, item)
	
	if stackSpace >= grabbed_slot.stack_count:
		add_item_to_slot(index, item, slot_data.stack_count)
		slot_data.item_data = null
	elif stackSpace > 0:
		add_item_to_slot(index, item, stackSpace)
		slot_data.stack_count = max(slot_data.stack_count-stackSpace, 0)
	else:
		slot_data.item_data = items[index].item_data
		slot_data.stack_count = items[index].stack_count
		set_item(index, grabbed_slot.item_data, grabbed_slot.stack_count)
	inventory_update_cell.emit(items[index], index)
	return slot_data
	

func slot_has_other_item (index, item):
	if items[index].item_data and not item == items[index].item_data:
		return true
	return false

func slot_is_empty(index:int):
	if items[index].item_data == null:
		return true
	return false

func stack_space_for_item(index, item):
	if slot_is_empty(index):
		return item.max_stack_size
	elif items[index].item_data == item:
		return items[index].item_data.max_stack_size - items[index].stack_count
	return 0

func add_item_to_slot(index, item, count):
	if slot_is_empty(index):
		items[index].item_data = item
		items[index].stack_count = min(count, item.max_stack_size)
	elif items[index].item_data == item and \
			items[index].stack_count < items[index].item_data.max_stack_size:
		items[index].stack_count += count
		items[index].stack_count = min(items[index].stack_count, item.max_stack_size)
	inventory_update_cell.emit(items[index], index)

func on_slot_clicked(index: int, button:int):
	inventory_interact.emit(self, index, button)

func initialize_empty_inventory(size:int):
	_library = load(_library_path)
	_size = size
	items.resize(size)
	for n in size:
		create_slot(n)

func initialize_inventory():
	for n in items.size():
		if not items[n]:
			create_slot(n)
		else:
			initialize_slot(n)

func initialize_slot (index:int):
	items[index].index = index
	items[index].slot_updated.connect(on_slot_updated)

func create_slot (index:int):
	items[index] = InventorySlot.new()
	items[index].stack_count = 0
	items[index].item_data = null
	items[index].index = index
	items[index].slot_updated.connect(on_slot_updated)

func add_item (item:ItemData, count:int):
	for slot in items:
		if count <= 0:
			return
		if slot.item_data == null:
			slot.item_data = item
			slot.stack_count = min(count, item.max_stack_size)
			count = max(count - item.max_stack_size, 0)
		elif item == slot.item_data:
			var available_space = item.max_stack_size - slot.stack_count
			slot.stack_count += min(count, available_space)
			count = max(count - available_space, 0)

func set_item (index:int, item:ItemData, count:int):
	items[index].stack_count = count
	items[index].item_data = item
	inventory_update_cell.emit(items[index], index)

func remove_item_at (position:int, count:int):
	if position < _size and position >= 0:
		items[position].stack_count = min(items[position].stack_count-count, 0)

func item_count (item:ItemData):
	var counter = 0
	for slot in items:
		if item == slot.item_data:
			counter += slot.stack_count
	return counter

func space_for_item (item:ItemData):
	var space = 0
	for slot in items:
		if slot.item_data == null:
			space += item.max_stack_size
		elif item == slot.item_data:
			var available_space = item.max_stack_size - slot.stack_count
			space += available_space
	return space

func on_slot_updated(index:int):
	inventory_update_cell.emit(items[index], index)

func remove_item (item:ItemData, count: int):
	for slot in items:
		if count <= 0:
			break
		if item == slot.item_data:
			pass

func clear():
	for slot in items:
		slot.stack_count = 0
		slot.item_data = null

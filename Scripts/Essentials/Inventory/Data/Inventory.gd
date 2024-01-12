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
	var slot_data = items[index]
	if slot_data:
		items[index] = null
		inventory_update.emit(self)
		return slot_data
	else:
		return null

func drop_slot(index:int, grabbed_slot:InventorySlot):
	if grabbed_slot and grabbed_slot.item_data:
		items[index] = grabbed_slot
		inventory_update.emit(self)

func stack_space_for_item(index, item):
	if items[index] == null:
		return item.max_stack_size
	elif items[index].item_data == item:
		return items[index].item_data.max_stack_size - items[index].stack_count
	return 0

func add_item_to_slot(index, item, count):
	if items[index] == null:
		initialize_slot(index)
		items[index].item_data = item
		items[index].stack_count = min(count, item.max_stack_size)
	elif items[index].item_data == item and \
			items[index].stack_count < items[index].item_data.max_stack_size:
		items[index].stack_count += count
		items[index].stack_count = min(items[index].stack_count, item.max_stack_size)
	inventory_update.emit(self)

func on_slot_clicked(index: int, button:int):
	print("clicked " + str(index) + " with button " + str(button))
	inventory_interact.emit(self, index, button)

func initialize_inventory(size:int):
	_library = load(_library_path)
	_size = size
	items.resize(size)
	for n in size:
		initialize_slot(n)

func initialize_slot (index:int):
	items[index] = InventorySlot.new()
	items[index].stack_count = 0
	items[index].item_data = null

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

func add_item_at (item:ItemData, count:int, index:int):
	pass

func set_item (position:int, item:ItemData, count:int):
	if position < _size and position >= 0:
		items[position].stack_count = count
		items[position].item_data = item


func switch_item (to_slot:InventorySlot, from_slot:InventorySlot):
	var temp_item = to_slot.item_data
	var temp_stack_count = to_slot.stack_count
	to_slot.item_data = from_slot.item_data
	to_slot.stack_count = from_slot.stack_count
	from_slot.item_data = temp_item
	from_slot.stack_count = temp_stack_count


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

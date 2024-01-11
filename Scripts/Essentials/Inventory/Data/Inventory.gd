extends Resource
class_name Inventory


@export var items: Array[InventorySlot]
var _size:int
const _library_path = "res://Data/Items/ItemLibrary.tres"
var _library:ItemLibrary


func initialize_inventory(size:int):
	_library = load(_library_path)
	_size = size
	items.resize(size)
	for n in size:
		items[n] = InventorySlot.new()
		items[n].stack_count = 0
		items[n].item_data = null


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

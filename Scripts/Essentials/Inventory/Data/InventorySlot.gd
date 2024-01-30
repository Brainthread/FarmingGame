extends Resource
class_name InventorySlot

signal slot_updated

@export var item_data:ItemData
@export var stack_count:int
var index

func update_slot():
	slot_updated.emit(index)
	
func decrease_stack(count:int):
	stack_count -= count
	if stack_count == 0:
		stack_count = 0
		item_data = null
	update_slot()


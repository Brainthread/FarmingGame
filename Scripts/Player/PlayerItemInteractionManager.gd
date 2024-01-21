extends Node

func hold_item(itemSlot:InventorySlot):
	if itemSlot:
		if itemSlot.item_data:
			holding_valid_item(itemSlot)
	else:
		pass
		
func holding_valid_item(itemSlot:InventorySlot):
	pass

func use_item(itemSlot:InventorySlot):
	pass

func use_valid_item(itemSlot:InventorySlot):
	pass
